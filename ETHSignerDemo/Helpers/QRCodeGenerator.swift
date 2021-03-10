//
//  QRCodeGenerator.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import UIKit

final class QRCodeGenerator {
    static let `default` = QRCodeGenerator()
    private init() {}
    func generateQRCode(message: Data) -> UIImage? {
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(message, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 8, y: 8)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
