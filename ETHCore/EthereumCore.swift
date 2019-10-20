//
//  EthCore.swift
//  ETHCore
//
//  Created by Ali Adam on 10/20/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import Foundation
import  Web3swift

public typealias ETHAddress = EthereumAddress
public typealias ETHKeyStore = PlainKeystore

public class EthereumCore {
    private static let ethereumClient = Web3.InfuraRinkebyWeb3().eth

    public static func getBalance(address: ETHAddress, complitionHandler: @escaping((Result<String,Error>) -> Void)) {
        do {
            let accountBalance = try ethereumClient.getBalance(address: address)
            if let balance = Web3.Utils.formatToEthereumUnits(accountBalance, toUnits: .eth, decimals: 3) {
                complitionHandler(.success(balance))
        }
        } catch {
            complitionHandler(.failure(error))

        }
       }

    
}
