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

class SetupViewController: ViewController {
    fileprivate var viewModel: SetupViewModel!
    fileprivate var router: SetupRouter!
    fileprivate let disposeBag = DisposeBag()

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
        privatKeyTXTF.rx.text.orEmpty.bind(to: viewModel.privatKey).disposed(by: disposeBag)
        viewModel.isValid.bind(to: doneBTN.rx.isEnabled).disposed(by: disposeBag)
        doneBTN.rx.tap.subscribe(onNext: { _ in
            self.hideKeyBoard()
            self.viewModel.createKeyStore()
        }).disposed(by: disposeBag)

    }
    /// handel error msg from viewModel
    func handleViewModelErrors() {
        viewModel.errorSubject.subscribe({ [weak self] (event) in
            if let msg =  event.element {
                self?.router.showErrorAlert(msg: msg)
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

        viewModel.keyStoreSbj.subscribe(onNext: { keystore in
            self.hideKeyBoard()
            self.router.navigateToAccountScreen(keystore)
        }).disposed(by: disposeBag)
    }
}
