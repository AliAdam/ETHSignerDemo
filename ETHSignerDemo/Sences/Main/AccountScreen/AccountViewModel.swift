//
//  AccountViewModel.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import RxSwift
import RxRelay
import ETHCore
class AccountViewModel: ViewModel {

    // input
    var keyStore: ETHKeyStore!
    private var repositry: BalanceRepository!

    // output
    let address = BehaviorRelay<String>(value: "")
    let balance = BehaviorRelay<String>(value: "")

    init(_ keyStore: ETHKeyStore, repositry: BalanceRepository) {
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
        self.activityIndicatorSubject.onNext(true)
        repositry.getBalance(address: ethAddress) { response in
            self.activityIndicatorSubject.onNext(false)
            switch response {
            case .success(let accountBalance):
                self.balance.accept("\(accountBalance) \(LocalizableWords.ether)")
            case .failure(let error):
                self.handleError(error: error)
            }

        }
    }
}
