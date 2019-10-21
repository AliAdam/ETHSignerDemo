//
//  EthCore.swift
//  ETHCore
//
//  Created by Ali Adam on 10/20/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import Foundation
import Web3swift
import secp256k1_swift

public class EthereumCore {

    public static let `default` = EthereumCore()

    private init() {}

    public func getBalance(wallet: EthereumWallet, completionHandler: @escaping((Result<String,Error>) -> Void)) {
        do {
            let address = wallet.address!
            let accountBalance = try wallet.web3Provider.eth.getBalance(address: address)
            if let balance = Web3.Utils.formatToEthereumUnits(accountBalance, toUnits: .eth, decimals: 3) {
                completionHandler(.success(balance))
            }
        } catch {
            completionHandler(.failure(error))
        }
    }
    public func signPersonalMessage(message:String, wallet: EthereumWallet, completionHandler: @escaping((Result<Data,Error>) -> Void)) {
        do {
            let address = wallet.address!
            let msgData = message.data(using: .utf8)
            let data = try wallet.web3Provider.personal.signPersonalMessage(message:msgData ?? Data() , from: address)
            completionHandler(.success(data.base64EncodedData()))
        } catch {
            completionHandler(.failure(error))
        }
    }
    //verify personal message
    public func verifyMessage(message: String, qrResultString: String, wallet: EthereumWallet,  completionHandler: @escaping((Result<Bool,Error>) -> Void)) {
        if let signature = Data(base64Encoded: qrResultString),
            let unmarshalledSignature = SECP256K1.unmarshalSignature(signatureData: signature), let msgData = message.data(using: .utf8) {
            print("V = " + String(unmarshalledSignature.v))
            //            print("R = " + Data(unmarshalledSignature.r).toHexString())
            //            print("S = " + Data(unmarshalledSignature.s).toHexString())
            //            print("Personal hash = " + Web3.Utils.hashPersonalMessage(message.data(using: .utf8)!)!.toHexString())
            do {
                let address = wallet.address!
                let recoveredSigner = try wallet.web3Provider.personal.ecrecover(personalMessage: msgData, signature: signature)
                completionHandler(.success(address == recoveredSigner))
            } catch {
                completionHandler(.failure(error))
            }
        }
        completionHandler(.success(false))
    }
}
