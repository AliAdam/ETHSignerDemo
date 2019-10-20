//
//  VerificationViewModel.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import RxSwift
import RxRelay
import ETHCore

class VerificationViewModel: ViewModel {

    // input
    let msg = BehaviorRelay<String>(value: "")
    var isValid: Observable<Bool>!
    let isValidSignature = PublishSubject<Bool>()
    private var keyStore: ETHKeyStore!
    private var repositry: VerificationRepository!

    // output

    // internal

    init(_ keyStore: ETHKeyStore, repositry: VerificationRepository) {
        super.init()
        self.keyStore = keyStore
        self.repositry = repositry
        setupRx()
    }

    func verifyMessage(qrCodeValue: String) {
        self.verify(qrCodeValue)
    }

}

// MARK: Setup
private extension VerificationViewModel {

    func setupRx() {
        isValid = self.msg.asObservable().map({!$0.isEmpty})
    }

    func verify(_ qrCodeValue: String) {
        self.activityIndicatorSubject.onNext(true)
        repositry.verifyMessage(message: msg.value, qrResultString: qrCodeValue, keystore: keyStore) { response in
            self.activityIndicatorSubject.onNext(false)
            switch response {
            case .success(let result):
                self.parseResult(result: result)
            case .failure(let error):
                self.handleError(error: error)
            }

        }
    }

    func parseResult(result: Bool) {

    if result {
    isValidSignature.onNext(result)
    } else {
        self.errorSubject.onNext("signature invalid")

        }
    }

}
