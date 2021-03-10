//
//  SetupRouter.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import Foundation
import  ETHCore
final class SetupRouter: Router {

    func navigateToAccountScreen(_ wallet:EthereumWallet) {
        let controller = AccountBuilder.viewController(wallet)
        viewController?.navigationController?.setViewControllers([controller], animated: true)

    }
}
