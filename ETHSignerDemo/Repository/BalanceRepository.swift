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
    func getBalance(address: ETHAddress, completionHandler: @escaping((Result<String,Error>) -> Void))
}

class RemoteBalanceRepository: BalanceRepository {
    func getBalance(address: ETHAddress, completionHandler: @escaping((Result<String,Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            EthereumCore.getBalance(address: address, completionHandler: completionHandler)
        }
       }
}

class MockupBalanceRepository: BalanceRepository {
    func getBalance(address: ETHAddress, completionHandler: @escaping((Result<String,Error>) -> Void)) {
        completionHandler(.success("18.7"))
    }
}

protocol SigningRepository {
    func signPersonalMessage(message:String, keystore: ETHKeyStore, completionHandler: @escaping((Result<Data,Error>) -> Void))
}

class RemoteSigningRepository: SigningRepository {
    func signPersonalMessage(message:String, keystore: ETHKeyStore, completionHandler: @escaping((Result<Data,Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            EthereumCore.signPersonalMessage(message: message, keystore: keystore, completionHandler: completionHandler)
        }
       }
}

class MockupSigningRepository: SigningRepository {
    func signPersonalMessage(message:String, keystore: ETHKeyStore, completionHandler: @escaping((Result<Data,Error>) -> Void)) {
        completionHandler(.success(Data()))
    }
}

protocol VerificationRepository {
    func verifyMessage(message: String, qrResultString: String, keystore: ETHKeyStore,  completionHandler: @escaping((Result<Bool,Error>) -> Void))
}

class RemoteVerificationRepository: VerificationRepository {
    func verifyMessage(message: String, qrResultString: String, keystore: ETHKeyStore,  completionHandler: @escaping((Result<Bool,Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            EthereumCore.verifyMessage(message: message, qrResultString: qrResultString, keystore: keystore,  completionHandler: completionHandler)
        }
       }
}

class MockupVerificationRepository: VerificationRepository {
    func verifyMessage(message: String, qrResultString: String, keystore: ETHKeyStore,  completionHandler: @escaping((Result<Bool,Error>) -> Void)) {
        completionHandler(.success(true))
    }
}
