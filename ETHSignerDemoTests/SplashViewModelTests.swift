//
//  SplashViewModelTests.swift
//  ETHSignerDemoTests
//
//  Created by Ali Adam on 10/21/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import XCTest
@testable import ETHSignerDemo
import RxSwift

final class SplashViewModelTests: XCTestCase {

    let disposeBag = DisposeBag()
    var viewModel: SplashViewModel!

    override func setUp() {
        viewModel = SplashViewModel()
    }

    override func tearDown() {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the final class.
    }
    func testOpenSetupScreen() {
        viewModel.networkSubject.onNext(true)
        let expectnetworkSubjectState = expectation(description:"expect to open setup screen")
        viewModel.networkSubject.subscribe( onNext: { _ in
            expectnetworkSubjectState.fulfill()
        }).disposed(by: disposeBag)
        wait(for: [expectnetworkSubjectState], timeout: 0.1)

    }

}
