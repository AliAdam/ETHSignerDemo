//
//  SigningBuilder.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit
import ETHCore
struct SigningBuilder {

    static func viewController(_ keyStore: ETHKeyStore) -> UIViewController {
        let repositry = RemoteSigningRepository()
        let viewModel = SigningViewModel(keyStore, repositry: repositry)
        let router = SigningRouter()
        let viewController : SigningViewController =  UIStoryboard.storyboard(.signing).instantiateViewController()
        router.viewController = viewController
        viewController.set(withViewModel: viewModel, router: router)
        return viewController

    }
}
