//
//  SplashRouter.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 6/16/19.
//  Copyright (c) 2019 Ali Adam. All rights reserved.
//

import Foundation

final class SplashRouter : Router {

    func navigateToSetupScreen() {
       let controller = SetupBuilder.viewController()
       viewController?.navigationController?.setViewControllers([controller], animated: true)
    }
}
