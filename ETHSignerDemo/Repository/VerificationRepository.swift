//
//  VerificationRepository.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/21/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import ETHCore

protocol VerificationRepository {
    func verifyMessage(message: String, qrResultString: String, wallet: EthereumWallet,  completionHandler: @escaping((Result<Bool,Error>) -> Void))
}

class RemoteVerificationRepository: VerificationRepository {
    func verifyMessage(message: String, qrResultString: String, wallet: EthereumWallet,  completionHandler: @escaping((Result<Bool,Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            EthereumCore.default.verifyMessage(message: message, qrResultString: qrResultString, wallet: wallet,  completionHandler: completionHandler)
        }
       }
}

class MockupVerificationRepository: VerificationRepository {
    func verifyMessage(message: String, qrResultString: String, wallet: EthereumWallet,  completionHandler: @escaping((Result<Bool,Error>) -> Void)) {
        completionHandler(.success(true))
    }
}
