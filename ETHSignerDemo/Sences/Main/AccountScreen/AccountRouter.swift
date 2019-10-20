//
//  AccountRouter.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import Foundation
import ETHCore
class AccountRouter: Router {

    func navigateToSigningScreen(_ keyStore:ETHKeyStore) {
            let controller = SigningBuilder.viewController(keyStore)
            viewController?.navigationController?.pushViewController(controller, animated: true)

    }
    func navigateToVerificationScreen(_ keyStore:ETHKeyStore) {
            let controller = VerificationBuilder.viewController(keyStore)
            viewController?.navigationController?.pushViewController(controller, animated: true)

    }
}
