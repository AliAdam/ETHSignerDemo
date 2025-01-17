//
//  SplashViewController.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 6/16/19.
//  Copyright (c) 2019 Ali Adam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SplashViewController: ViewController {
    private let viewModel = SplashViewModel()
    private let router =  SplashRouter()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupRx()
    }
}

// MARK: Setup
private extension SplashViewController {

    func setupViews() {
        router.viewController = self
        hideNavBar()
    }

    func setupRx() {
        // when there is a network go to the navigateToSetupScreen
        viewModel.networkStatusDidChangeSubject.subscribe({ [weak self] (event) in
            if event.element! {
                self?.router.navigateToSetupScreen()
            }
        }).disposed(by: disposeBag)
    }
}
