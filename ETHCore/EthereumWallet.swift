//
//  EthereumWallet.swift
//  ETHCore
//
//  Created by Ali Adam on 10/21/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import Web3swift
public class EthereumWallet {
    let web3Provider = Web3.InfuraRinkebyWeb3()
    var keyStore: PlainKeystore!
    var keyStoreManager: KeystoreManager!
    var address: EthereumAddress!
    public init?(privateKey: String) {
        guard let keyStore = self.createKeyStore(privateKey) else {return nil}
        self.keyStore = keyStore
        createKeystoreManager()
    }

    public func getAddress() -> EthereumAddress {
        return address
    }
}

private extension EthereumWallet {
    func createKeyStore(_ privateKey: String) -> PlainKeystore? {
        guard let  keyStore =  ETHKeyStore.init(privateKey: privateKey) else { return nil }
        return keyStore
    }
    func createKeystoreManager() {
        let keyStoreManager = KeystoreManager([self.keyStore])
        web3Provider.addKeystoreManager(keyStoreManager)
        self.keyStoreManager = keyStoreManager
        self.address = self.keyStoreManager.addresses![0]
    }
}