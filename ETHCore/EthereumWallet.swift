//
//  EthereumWallet.swift
//  ETHCore
//
//  Created by Ali Adam on 10/21/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import web3swift
public final class EthereumWallet {

    let web3Provider = Web3.InfuraRinkebyWeb3()
    var keyStore: PlainKeystore!
    var keyStoreManager: KeystoreManager!
    var address: EthereumAddress!

    public init?(privateKey: String) {
        guard let keyStore = self.createKeyStore(privateKey) else {return nil}
        self.keyStore = keyStore
        createKeystoreManager()
    }

    public func getAddress() -> String {
        return address.address
    }
}

private extension EthereumWallet {
    func createKeyStore(_ privateKey: String) -> PlainKeystore? {
        guard let  keyStore =  PlainKeystore.init(privateKey: privateKey) else { return nil }
        return keyStore
    }
    func createKeystoreManager() {
        let keyStoreManager = KeystoreManager([self.keyStore])
        web3Provider.addKeystoreManager(keyStoreManager)
        self.keyStoreManager = keyStoreManager
        self.address = self.keyStoreManager.addresses![0]
    }
}
