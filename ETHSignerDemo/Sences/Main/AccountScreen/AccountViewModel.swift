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
    var wallet: EthereumWallet!
    private var repositry: BalanceRepository!

    // output
    let address = BehaviorRelay<String>(value: "")
    let balance = BehaviorRelay<String>(value: "")

    init(_ wallet: EthereumWallet, repositry: BalanceRepository) {
        super.init()
        self.wallet = wallet
        self.repositry = repositry
        setupRx()
    }
}

// MARK: Setup
private extension AccountViewModel {

    func setupRx() {
        getBalance()
        address.accept(wallet.getAddress())
    }
    func getBalance() {
        self.activityIndicatorSubject.onNext(true)
        repositry.getBalance(wallet: wallet) { response in
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
