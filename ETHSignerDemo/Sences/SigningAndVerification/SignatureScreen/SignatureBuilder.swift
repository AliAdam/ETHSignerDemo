//
//  SignatureBuilder.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit

struct SignatureBuilder {

    static func viewController(_ qrCode: UIImage, _ msg: String) -> UIViewController {
        let viewModel = SignatureViewModel(qrCode, msg)
        let viewController: SignatureViewController =  UIStoryboard.storyboard(.signing).instantiateViewController()
        viewController.set(withViewModel: viewModel)
        return viewController
    }
}
