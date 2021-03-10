//
//  UINavigationControllerExtension.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 6/16/19.
//  Copyright © 2019 Ali Adam. All rights reserved.
//

import UIKit
extension UINavigationController {

    @IBInspectable var backgroundColor: UIColor {
        get {
            return self.view.backgroundColor ?? UIColor.black
        }
        set {
            self.view.backgroundColor = newValue
        }
    }

}
