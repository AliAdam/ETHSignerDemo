//
//  SetupViewController.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SetupViewController: ViewController {
    private var viewModel: SetupViewModel!
    private var router: SetupRouter!
    private let disposeBag = DisposeBag()

    @IBOutlet weak var privatKeyTXTF: UITextField!
    @IBOutlet weak var doneBTN: UIButton!

    func set(withViewModel viewModel: SetupViewModel, router: SetupRouter) {
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
private extension SetupViewController {

    func setupViews() {
        showNavBar()
        self.title = LocalizableWords.setup
    }

    func setupRx() {
        handleViewModelErrors()
        handleViewModelActivityIndicatorStatus()
        handleViewModelKeyStoreSbj()
        handleDoneBTNAction()
        privatKeyTXTF.rx.text.orEmpty.bind(to: viewModel.privateKey).disposed(by: disposeBag)
        viewModel.isValid.bind(to: doneBTN.rx.isEnabled).disposed(by: disposeBag)

    }

    func handleDoneBTNAction() {
        doneBTN.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.hideKeyBoard()
            self?.viewModel.createWallet()
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

        viewModel.ethereumWalletSbj.subscribe(onNext: { [weak self] wallet in
            self?.hideKeyBoard()
            self?.setActivatyIndicatorVisabilty(visable: false)
            self?.router.navigateToAccountScreen(wallet)
        }).disposed(by: disposeBag)
    }
}
