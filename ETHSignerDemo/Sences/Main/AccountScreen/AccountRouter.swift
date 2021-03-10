//
//  AccountRouter.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import Foundation
import ETHCore
final class AccountRouter: Router {

    func navigateToSigningScreen(_ wallet:EthereumWallet) {
            let controller = SigningBuilder.viewController(wallet)
            viewController?.navigationController?.pushViewController(controller, animated: true)

    }
    func navigateToVerificationScreen(_ wallet:EthereumWallet) {
            let controller = VerificationBuilder.viewController(wallet)
            viewController?.navigationController?.pushViewController(controller, animated: true)

    }
}
