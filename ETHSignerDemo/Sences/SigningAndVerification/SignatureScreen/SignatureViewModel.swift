//
//  SignatureViewModel.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import RxSwift

class SignatureViewModel: ViewModel {

    // input
    let msgSbj = BehaviorSubject<String>(value:"")
    let qrCodeSbj = BehaviorSubject<UIImage>(value: UIImage())

    // output

    // internal
    init(_ qrCode: UIImage, _ msg: String) {
        super.init()
        qrCodeSbj.onNext(qrCode)
        msgSbj.onNext(msg)

    }

}

// MARK: Setup
private extension SignatureViewModel {

    func setupRx() {

    }
}
