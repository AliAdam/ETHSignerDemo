//
//  VerificationBuilder.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit
import ETHCore
struct VerificationBuilder {

    static func viewController(_ wallet: EthereumWallet) -> UIViewController {
        let repositry = RemoteVerificationRepository()
        let viewModel = VerificationViewModel(wallet, repositry: repositry)
        let router = VerificationRouter()
        let viewController : VerificationViewController =  UIStoryboard.storyboard(.signing).instantiateViewController()
        router.viewController = viewController
        viewController.set(withViewModel: viewModel, router: router)
        return viewController

    }
}
