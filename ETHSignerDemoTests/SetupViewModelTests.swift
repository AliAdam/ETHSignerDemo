//
//  ETHSignerDemoTests.swift
//  ETHSignerDemoTests
//
//  Created by Ali Adam on 10/19/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import XCTest
@testable import ETHSignerDemo
import RxSwift

final class SetupViewModelTests: XCTestCase {

    let disposeBag = DisposeBag()
    var viewModel: SetupViewModel!
    let privateKey = "0xf78e4b9398b40fec128f930687d69ca3fc67a563e1f0060c3100c3a0557fe822"

    override func setUp() {
        viewModel = SetupViewModel()
    }

    override func tearDown() {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the final class.
    }
    func testInvalidPrivateKey() {
        viewModel.privateKey.accept("sdfghtyrewrtytrfdsfgh")
        let expectErrorMSG = expectation(description:"expect error MSG")
        viewModel.errorSubject.subscribe( onNext: { _ in
            expectErrorMSG.fulfill()
        }).disposed(by: disposeBag)
        viewModel.createWallet()
        wait(for: [expectErrorMSG], timeout: 0.1)

    }
    func testValidatePrivateKeySuccess() {
        viewModel.privateKey.accept(privateKey)
        let expectUpdateDoneBTNState = expectation(description:"Enable Done  BTN")
        viewModel.isValid.subscribe( onNext: { _ in
            expectUpdateDoneBTNState.fulfill()
        }).disposed(by: disposeBag)
        wait(for: [expectUpdateDoneBTNState], timeout: 0.1)
        viewModel.createWallet()

    }

    func testCreateWallet() {
        viewModel.privateKey.accept(privateKey)
        let expectToGetWallet = expectation(description:"expect to create wallet successfully")
        viewModel.ethereumWalletSbj.subscribe( onNext: { _ in
            expectToGetWallet.fulfill()
        }).disposed(by: disposeBag)
        viewModel.createWallet()
        wait(for: [expectToGetWallet], timeout: 1.0)

    }

}
