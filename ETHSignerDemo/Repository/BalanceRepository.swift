//
//  BalanceRepository.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import Foundation
import ETHCore

protocol BalanceRepository {
    func getBalance(address: ETHAddress, complitionHandler: @escaping((Result<String,Error>) -> Void))
}

class RemoteBalanceRepository: BalanceRepository {
    func getBalance(address: ETHAddress, complitionHandler: @escaping((Result<String,Error>) -> Void)) {
        DispatchQueue.global().async {
            EthereumCore.getBalance(address: address, complitionHandler: complitionHandler)
        }
       }
}

class MockupBalanceRepository: BalanceRepository {
    func getBalance(address: ETHAddress, complitionHandler: @escaping((Result<String,Error>) -> Void)) {
        complitionHandler(.success("18.7"))
    }
}
