//
//  AccountViewModel.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import RxSwift
import RxRelay
import Web3swift
class AccountViewModel: ViewModel {

    // input
    private var keyStore: PlainKeystore!
    private var repositry: BalanceRepository!

    // output
    let address = BehaviorRelay<String>(value: "")
    let balance = BehaviorRelay<String>(value: "")

    init(_ keyStore: PlainKeystore, repositry: BalanceRepository) {
        super.init()
        self.keyStore = keyStore
        self.repositry = repositry
        setupRx()
    }
}

// MARK: Setup
private extension AccountViewModel {

    func setupRx() {
        getBalance()
    }
    func getBalance() {
        let ethAddress = keyStore.addresses!.first!
        address.accept(ethAddress.address)
        let accountBalance = repositry.getBalance(address: ethAddress)
        balance.accept("\(accountBalance) \(LocalizableWords.ether)")
    }
}
