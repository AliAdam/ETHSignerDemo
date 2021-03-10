//
//  AccountViewController.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class AccountViewController: ViewController {
    private var viewModel: AccountViewModel!
    private var router: AccountRouter!
    private let disposeBag = DisposeBag()
    @IBOutlet weak var addressLBL: UILabel!
    @IBOutlet weak var balanceLBL: UILabel!
    @IBOutlet weak var signingBTN: UIButton!
    @IBOutlet weak var verifyBTN: UIButton!

    func set(withViewModel viewModel: AccountViewModel, router: AccountRouter) {
        self.viewModel = viewModel
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()
        setupRx()
    }
}

// MARK: Setup
private extension AccountViewController {

    func setupViews() {
        showNavBar()
        self.title = LocalizableWords.account

    }

    func setupLayout() {

    }

    func setupRx() {
        handleViewModelErrors()
        handleViewModelActivityIndicatorStatus()
        handleVerifyBTNAction()
        handleSigningBTNAction()
        self.viewModel.address.bind(to: addressLBL.rx.text).disposed(by: disposeBag)
        self.viewModel.balance.bind(to: balanceLBL.rx.text).disposed(by: disposeBag)
    }

    func handleVerifyBTNAction() {
        verifyBTN.rx.tap.subscribe(onNext: { [weak self] _ in
            let wallet = self?.viewModel.wallet
            self?.router.navigateToVerificationScreen(wallet!)
        }).disposed(by: disposeBag)

    }
    func handleSigningBTNAction() {
        signingBTN.rx.tap.subscribe(onNext: { [weak self] _ in
            let wallet = self?.viewModel.wallet
            self?.router.navigateToSigningScreen(wallet!)
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

}
