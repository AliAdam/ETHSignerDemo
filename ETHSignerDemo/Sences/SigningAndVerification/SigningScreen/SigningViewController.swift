//
//  SigningViewController.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SigningViewController: ViewController {
    private var viewModel: SigningViewModel!
    private var router: SigningRouter!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var msgTXTF: UITextField!
    @IBOutlet weak var doneBTN: UIButton!

    func set(withViewModel viewModel: SigningViewModel, router: SigningRouter) {
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
private extension SigningViewController {

    func setupViews() {
        self.title = LocalizableWords.signing
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
            self?.viewModel.signMessage()
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

        viewModel.qrCodeSbj.subscribe(onNext: { qrCode in
            self.hideKeyBoard()
            self.setActivatyIndicatorVisabilty(visable: false)
            DispatchQueue.main.async {
                self.router.navigateToSignatureScreen(qrCode, self.viewModel.msg.value)
            }
        }).disposed(by: disposeBag)
    }
}
