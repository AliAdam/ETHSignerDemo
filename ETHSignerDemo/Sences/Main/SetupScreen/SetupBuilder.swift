//
//  SetupBuilder.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/19/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit

struct SetupBuilder {

    static func viewController() -> UIViewController {
        let viewModel = SetupViewModel()
        let router = SetupRouter()

        let viewController : SetupViewController =  UIStoryboard.storyboard(.main).instantiateViewController()
        router.viewController = viewController
        viewController.set(withViewModel: viewModel, router: router)
        return viewController
    }
}
