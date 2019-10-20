//
//  SetupRouter.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import Foundation
import  ETHCore
class SetupRouter: Router {

    func navigateToAccountScreen(_ keyStore:ETHKeyStore) {
        let controller = AccountBuilder.viewController(keyStore)
        viewController?.navigationController?.setViewControllers([controller], animated: true)

    }
}
