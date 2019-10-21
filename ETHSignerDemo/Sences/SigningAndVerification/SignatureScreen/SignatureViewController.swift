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

class SignatureViewController: ViewController {
    fileprivate var viewModel: SignatureViewModel!
    fileprivate var router: SignatureRouter!
    fileprivate let disposeBag = DisposeBag()
    @IBOutlet weak var msgLBL: UILabel!
    @IBOutlet weak var qrCodeIMGV: UIImageView!

    func set(withViewModel viewModel: SignatureViewModel, router: SignatureRouter) {
        self.viewModel = viewModel
        self.router = router
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()
        setupRx()
    }
}

// MARK: Setup
private extension SignatureViewController {

    func setupViews() {
        self.title = LocalizableWords.signature
    }

    func setupLayout() {

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
