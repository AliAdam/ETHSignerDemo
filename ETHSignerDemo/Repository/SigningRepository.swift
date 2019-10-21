//
//  SigningRepository.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/21/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import ETHCore

protocol SigningRepository {
    func signPersonalMessage(message:String, wallet: EthereumWallet, completionHandler: @escaping((Result<Data,Error>) -> Void))
}

class RemoteSigningRepository: SigningRepository {
    func signPersonalMessage(message:String, wallet: EthereumWallet, completionHandler: @escaping((Result<Data,Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            EthereumCore.default.signPersonalMessage(message: message, wallet: wallet, completionHandler: completionHandler)
        }
       }
}

class MockupSigningRepository: SigningRepository, MockUpWalletAndAddress {
    func signPersonalMessage(message:String, wallet: EthereumWallet, completionHandler: @escaping((Result<Data,Error>) -> Void)) {
        completionHandler(.success(Data()))
    }
}
