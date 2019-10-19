//
//  StringExtension.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 6/17/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import Foundation

extension String {
    func matchRegex(regex : String ) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }

    /// cheack if this string is availd url or not
    ///
    /// - Returns:  Returns: bool value indicate if it url or not
    func isValidPrivateKey() -> Bool {
        let regex : String = "^0x[a-fA-F0-9]{64}$"
        return self.matchRegex(regex: regex)
    }

}

import UIKit
extension UIButton {

    public override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }

}
