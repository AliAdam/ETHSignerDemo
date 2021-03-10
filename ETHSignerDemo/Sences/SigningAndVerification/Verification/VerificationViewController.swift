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

final class VerificationViewController: ViewController {
    private var viewModel: VerificationViewModel!
    private var router: VerificationRouter!
    private let disposeBag = DisposeBag()

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
        self.title = LocalizableWords.verification
    }

    func setupRx() {
        handleViewModelErrors()
        handleViewModelActivityIndicatorStatus()
        handleViewModelKeyStoreSbj()
        handleDoneBTNAction()
        msgTXTF.rx.text.orEmpty.bind(to: viewModel.msg).disposed(by: disposeBag)
        viewModel.isValid.bind(to: doneBTN.rx.isEnabled).disposed(by: disposeBag)

    }

    func handleDoneBTNAction() {
        doneBTN.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.hideKeyBoard()
            DispatchQueue.main.async {
                self?.openQRCodeReaderScreen()

            }
        }).disposed(by: disposeBag)

    }
    /// handel error msg from viewModel
    func handleViewModelErrors() {
        viewModel.errorSubject.subscribe(onNext: { [weak self] msg in
            self?.router.showErrorAlert(msg: msg)
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

        viewModel.isValidSignature.subscribe(onNext: { [weak self] isValidSignature in
            self?.hideKeyBoard()
            self?.setActivatyIndicatorVisabilty(visable: false)
            if isValidSignature {
                DispatchQueue.main.async {
                    self?.showVaildAlert()
                }
            }

        }).disposed(by: disposeBag)
    }

    func openQRCodeReaderScreen() {
        self.router.presentQRCodeScreen { [weak self] value in
            self?.viewModel.verifyMessage(qrCodeValue: value)
        }
    }

    func showVaildAlert() {

        self.presentAlertWithTitle(title: "", message: "signature valid", options: "OK") { (_) in

        }
    }
}
