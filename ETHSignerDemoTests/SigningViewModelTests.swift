//
//  SigningViewModelTests.swift
//  ETHSignerDemoTests
//
//  Created by Ali Adam on 10/21/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import XCTest
@testable import ETHSignerDemo
import RxSwift

class SigningViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()
    var viewModel: SigningViewModel!
    let repo = MockupSigningRepository()

     override func setUp() {
          viewModel = SigningViewModel(repo.getMockupWallet(), repositry: repo)
      }

      func testValidateMSGSuccess() {
            viewModel.msg.accept("test")
            let expectUpdateDoneBTNState = expectation(description:"Enable Done  BTN")
            viewModel.isValid.subscribe( onNext: { _ in
                expectUpdateDoneBTNState.fulfill()
            }).disposed(by: disposeBag)
            wait(for: [expectUpdateDoneBTNState], timeout: 0.1)
        }

    func testCreateQRCode() {
           viewModel.msg.accept("test")
           let expectToGetWallet = expectation(description:"expect to create wallet successfully")
           viewModel.qrCodeSbj.subscribe( onNext: { _ in
               expectToGetWallet.fulfill()
           }).disposed(by: disposeBag)
           viewModel.signMessage()
           wait(for: [expectToGetWallet], timeout: 1.0)

       }

}
