//
//  MockUpWalletAndAddress.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/22/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//
import ETHCore

protocol MockUpWalletAndAddress {
    func getMockupWallet() -> EthereumWallet
    func getAddress() -> String
}

extension MockUpWalletAndAddress {
    func getMockupWallet() -> EthereumWallet {
        let wallet = EthereumWallet(privateKey: "0xf78e4b9398b40fec128f930687d69ca3fc67a563e1f0060c3100c3a0557fe822")!
        return wallet

    }

    func getAddress() -> String {
        return "0x65ef0e32a508d52128e5f914ce8f5aec2c452c78"

    }
}
