//
//  AccountViewModelTests.swift
//  ETHSignerDemoTests
//
//  Created by Ali Adam on 10/21/19.
//  Copyright © 2019 AliAdam. All rights reserved.
//

import XCTest
@testable import ETHSignerDemo
import RxSwift

final class AccountViewModelTests: XCTestCase {

    let disposeBag = DisposeBag()
    var viewModel: AccountViewModel!
    let repo = MockupBalanceRepository()

    override func setUp() {
        viewModel = AccountViewModel(repo.getMockupWallet(), repositry: repo)
    }
    func testVaildAddrss() {
        XCTAssertEqual(viewModel.address.value.lowercased(), repo.getAddress().lowercased(), "expect same address")
    }

    func testVaildBalance() {
        repo.getBalance(wallet: repo.getMockupWallet()) { (result) in
            switch result {
            case .success(let balance):
                XCTAssertEqual(self.viewModel.balance.value, "\(balance) \(LocalizableWords.ether)", "expect same balance")
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }

    override func tearDown() {
        viewModel = nil
    }

}
