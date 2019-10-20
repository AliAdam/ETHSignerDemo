//
//  UIButtonExtension.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import Foundation

import UIKit
extension UIButton {

    public override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }

}
