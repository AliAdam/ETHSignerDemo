//
//  BalanceRepository.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import Foundation
import Web3swift

protocol BalanceRepository {
    func getBalance(address: EthereumAddress) -> String
}

class RemoteBalanceRepository: BalanceRepository {
    func getBalance(address: EthereumAddress) -> String {
        let accountBalance = try! Web3.InfuraRinkebyWeb3().eth.getBalance(address: address)
        if let formatedBalance = Web3.Utils.formatToEthereumUnits(accountBalance, toUnits: .eth, decimals: 3) {
            return formatedBalance
        }
        return ""
    }
}

class MockupBalanceRepository: BalanceRepository {
    func getBalance(address: EthereumAddress) -> String {
        return "18.7"
    }
}
