//
//  SigningRouter.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import Foundation
import UIKit

class SigningRouter: Router {

    func navigateToSignatureScreen(_ qrCode: UIImage, _ msg: String) {
        let controller = SignatureBuilder.viewController(qrCode, msg)
        viewController?.navigationController?.pushViewController(controller, animated: true)

    }
}
