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

public typealias ETHAddress = EthereumAddress
public typealias ETHKeyStore = PlainKeystore

public class EthereumCore {
    private static let web3 = Web3.InfuraRinkebyWeb3()
    private static let ethereumClient = web3.eth

    public static func getBalance(address: ETHAddress, completionHandler: @escaping((Result<String,Error>) -> Void)) {
        do {
            let accountBalance = try ethereumClient.getBalance(address: address)
            if let balance = Web3.Utils.formatToEthereumUnits(accountBalance, toUnits: .eth, decimals: 3) {
                completionHandler(.success(balance))
            }
        } catch {
            completionHandler(.failure(error))

        }
    }

    public static func signPersonalMessage(message:String, keystore: ETHKeyStore, completionHandler: @escaping((Result<Data,Error>) -> Void)) {
        do {
            let address = createKeystoreManager(keystore)
            let msgData = message.data(using: .utf8)
            let data = try web3.personal.signPersonalMessage(message:msgData ?? Data() , from: address)
            completionHandler(.success(data.base64EncodedData()))

        } catch {
            completionHandler(.failure(error))

        }
    }

    //verify personal message
    public static func verifyMessage(message: String, qrResultString: String, keystore: ETHKeyStore,  completionHandler: @escaping((Result<Bool,Error>) -> Void)) {

        if let signature = Data(base64Encoded: qrResultString),
            let unmarshalledSignature = SECP256K1.unmarshalSignature(signatureData: signature), let msgData = message.data(using: .utf8) {
            let address = createKeystoreManager(keystore)
//            print("V = " + String(unmarshalledSignature.v))
//            print("R = " + Data(unmarshalledSignature.r).toHexString())
//            print("S = " + Data(unmarshalledSignature.s).toHexString())
//            print("Personal hash = " + Web3.Utils.hashPersonalMessage(message.data(using: .utf8)!)!.toHexString())

            do {
                let recoveredSigner = try web3.personal.ecrecover(personalMessage: msgData, signature: signature)
                completionHandler(.success(address == recoveredSigner))

            } catch {
                completionHandler(.failure(error))
            }

        }

        completionHandler(.success(false))
    }

    private static func createKeystoreManager(_ keystore: ETHKeyStore) -> EthereumAddress {
        let keystoreManager = KeystoreManager([keystore])
        web3.addKeystoreManager(keystoreManager)
        let address = keystoreManager.addresses![0]
        return address

    }
}
