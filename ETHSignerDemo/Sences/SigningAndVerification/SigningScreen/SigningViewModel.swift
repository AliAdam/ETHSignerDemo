//
//  SigningViewModel.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import RxSwift
import RxRelay
import ETHCore

class SigningViewModel: ViewModel {

    // input
    let msg = BehaviorRelay<String>(value: "")
    var isValid: Observable<Bool>!
    let qrCodeSbj = PublishSubject<UIImage>()
    private var wallet: EthereumWallet!
    private var repositry: SigningRepository!

    // output

    // internal

    init(_ wallet: EthereumWallet, repositry: SigningRepository) {
        super.init()
        self.wallet = wallet
        self.repositry = repositry
        setupRx()
    }

    func signMessage() {
        self.signing()
    }

}

// MARK: Setup
private extension SigningViewModel {

    func setupRx() {
        isValid = self.msg.asObservable().map({!$0.isEmpty})
    }

    func signing() {
        self.activityIndicatorSubject.onNext(true)
        repositry.signPersonalMessage(message: msg.value, wallet: wallet) { response in
            self.activityIndicatorSubject.onNext(false)
            switch response {
            case .success(let data):
                self.genrateQRCode(data: data)
            case .failure(let error):
                self.handleError(error: error)
            }

        }
    }

    func genrateQRCode(data: Data) {

        if let image = QRCodeGenerator.default.generateQRCode(message: data) {
            self.qrCodeSbj.onNext(image)
            return
        }
        self.errorSubject.onNext(LocalizableWords.qrCodeGenratorError)
    }

}
