//
//  SetupViewModel.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import RxSwift
import RxRelay
import ETHCore

class SetupViewModel: ViewModel {

    // input
    let privateKey = BehaviorRelay<String>(value: "")
    var isValid: Observable<Bool>!
    let ethereumWalletSbj = PublishSubject<EthereumWallet>()

    // output

    // internal

    override init() {
        super.init()
        setupRx()

    }

    func createKeyStore() {
        self.activityIndicatorSubject.onNext(true)
        guard let wallet = EthereumWallet(privateKey: privateKey.value) else {
            self.activityIndicatorSubject.onNext(false)
            self.errorSubject.onNext(LocalizableWords.invaildPrivateKey)
            return
        }

        self.ethereumWalletSbj.onNext(wallet)

    }
}

// MARK: Setup
private extension SetupViewModel {

    func setupRx() {
        isValid = self.privateKey.asObservable().map({$0.isValidPrivateKey()})
    }

}
