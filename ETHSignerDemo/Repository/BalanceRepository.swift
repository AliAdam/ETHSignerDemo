//
//  BalanceRepository.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import ETHCore

protocol BalanceRepository {
    func getBalance(wallet: EthereumWallet, completionHandler: @escaping((Result<String,Error>) -> Void))
}

final class RemoteBalanceRepository: BalanceRepository {
    func getBalance(wallet: EthereumWallet, completionHandler: @escaping((Result<String,Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            EthereumCore.default.getBalance(wallet: wallet, completionHandler: completionHandler)
        }
    }
}

final class MockupBalanceRepository: BalanceRepository, MockUpWalletAndAddress {
    func getBalance(wallet: EthereumWallet, completionHandler: @escaping((Result<String,Error>) -> Void)) {
        completionHandler(.success("0"))
    }

}
