//
//  SignatureViewController.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 10/20/19.
//  Copyright (c) 2019 AliAdam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SignatureViewController: ViewController {
    private var viewModel: SignatureViewModel!
    private let disposeBag = DisposeBag()
    @IBOutlet weak var msgLBL: UILabel!
    @IBOutlet weak var qrCodeIMGV: UIImageView!

    func set(withViewModel viewModel: SignatureViewModel) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupRx()
    }
}

// MARK: Setup
private extension SignatureViewController {

    func setupViews() {
        self.title = LocalizableWords.signature
    }

    func setupRx() {

        viewModel.qrCodeSbj.subscribe(onNext: { [weak self] qrCode in
            self?.qrCodeIMGV.image = qrCode
        }).disposed(by: disposeBag)

        viewModel.msgSbj.subscribe(onNext: { [weak self] msg in
            self?.msgLBL.text = msg
        }).disposed(by: disposeBag)

    }
}
