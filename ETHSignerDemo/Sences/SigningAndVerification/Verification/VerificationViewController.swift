//
//  VerificationViewController.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VerificationViewController: ViewController {
    fileprivate var viewModel: VerificationViewModel!
    fileprivate var router: VerificationRouter!
    fileprivate let disposeBag = DisposeBag()

    @IBOutlet weak var msgTXTF: UITextField!
    @IBOutlet weak var doneBTN: UIButton!

    func set(withViewModel viewModel: VerificationViewModel, router: VerificationRouter) {
        self.viewModel = viewModel
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupRx()
    }
}

// MARK: Setup
private extension VerificationViewController {

    func setupViews() {
        showNavBar()
        self.title = LocalizableWords.verification
    }

    func setupRx() {
        handleViewModelErrors()
        handleViewModelActivityIndicatorStatus()
        handleViewModelKeyStoreSbj()
        msgTXTF.rx.text.orEmpty.bind(to: viewModel.msg).disposed(by: disposeBag)
        viewModel.isValid.bind(to: doneBTN.rx.isEnabled).disposed(by: disposeBag)
        doneBTN.rx.tap.subscribe(onNext: { _ in
            self.hideKeyBoard()
            DispatchQueue.main.async {
                self.openQRCodeReaderScreen()

            }
        }).disposed(by: disposeBag)

    }
    /// handel error msg from viewModel
    func handleViewModelErrors() {
        viewModel.errorSubject.subscribe({ [weak self] (event) in
            if let msg =  event.element {
                DispatchQueue.main.async {
                    self?.router.showErrorAlert(msg: msg)
                }
            }
        }).disposed(by: disposeBag)
    }

    /// handle sActivaty Indicator Visabilty
    func handleViewModelActivityIndicatorStatus() {
        viewModel.activityIndicatorSubject.subscribe({ [weak self] (event) in
            self?.setActivatyIndicatorVisabilty(visable: event.element ?? false)
        }).disposed(by: disposeBag)
    }

    /// handle sActivaty Indicator Visabilty
    func handleViewModelKeyStoreSbj() {

        viewModel.isValidSignature.subscribe(onNext: { isValidSignature in
            self.hideKeyBoard()
            self.setActivatyIndicatorVisabilty(visable: false)
            if isValidSignature {
                DispatchQueue.main.async {
                    self.showVaildAlert()
                }
            }

        }).disposed(by: disposeBag)
    }

    func openQRCodeReaderScreen() {
        self.router.presentQRCodeScreen { value in
            self.viewModel.verifyMessage(qrCodeValue: value)
        }
    }

    func showVaildAlert() {

        self.presentAlertWithTitle(title: "", message: "signature valid", options: "OK") { (_) in

        }
    }
}
