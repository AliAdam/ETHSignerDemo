//
//  AccountBuilder.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit
import Web3swift

struct AccountBuilder {

    static func viewController(_ keyStore: PlainKeystore) -> UIViewController {
        let repositry = RemoteBalanceRepository()
        let viewModel = AccountViewModel(keyStore, repositry: repositry)
        let router = AccountRouter()
             let viewController : AccountViewController =  UIStoryboard.storyboard(.main).instantiateViewController()
        router.viewController = viewController
        viewController.set(withViewModel: viewModel, router: router)
        return viewController

    }
}
