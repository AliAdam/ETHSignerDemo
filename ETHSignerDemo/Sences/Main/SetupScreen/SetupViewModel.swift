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
    let privatKey = BehaviorRelay<String>(value: "")
    var isValid: Observable<Bool>!
    let keyStoreSbj = PublishSubject<ETHKeyStore>()

    // output

    // internal

    override init() {
        super.init()
        setupRx()

    }

    func createKeyStore() {
        self.activityIndicatorSubject.onNext(true)
        guard let  keyStore =  ETHKeyStore.init(privateKey: privatKey.value) else {
            self.activityIndicatorSubject.onNext(false)
            self.errorSubject.onNext(LocalizableWords.invaildPrivateKey)
            return
        }

        self.keyStoreSbj.onNext(keyStore)

    }
}

// MARK: Setup
private extension SetupViewModel {

    func setupRx() {
        isValid = self.privatKey.asObservable().map({$0.isValidPrivateKey()})
    }

}
