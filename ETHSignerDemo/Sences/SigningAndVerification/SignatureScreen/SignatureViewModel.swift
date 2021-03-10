//
//  SignatureViewModel.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import RxSwift

final class SignatureViewModel: ViewModel {

    let msgSbj = BehaviorSubject<String>(value:"")
    let qrCodeSbj = BehaviorSubject<UIImage>(value: UIImage())

    init(_ qrCode: UIImage, _ msg: String) {
        super.init()
        qrCodeSbj.onNext(qrCode)
        msgSbj.onNext(msg)

    }

}
