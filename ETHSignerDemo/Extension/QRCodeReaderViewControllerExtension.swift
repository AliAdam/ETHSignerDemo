//
//  QRCodeReaderViewControllerExtension.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import QRCodeReader
extension QRCodeReaderViewController {
    static func getDefaultInstance () -> QRCodeReaderViewController {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
        }
        let  readerVC  = QRCodeReaderViewController(builder: builder)
        return readerVC
    }
}
