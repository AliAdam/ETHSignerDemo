//
//  VerificationRouter.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import Foundation
import UIKit
import QRCodeReader

class VerificationRouter: Router {

    func presentQRCodeScreen(completionHandler: @escaping ((String) -> Void)) {
        let  readerVC  = QRCodeReaderViewController.getDefaultInstance()
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            if let value = result?.value {
                print(value)
                completionHandler(value)
                self.viewController?.navigationController?.popViewController(animated: true)
            }
        }
        readerVC.modalPresentationStyle = .formSheet
        viewController?.navigationController?.pushViewController(readerVC, animated: true)

    }
}
