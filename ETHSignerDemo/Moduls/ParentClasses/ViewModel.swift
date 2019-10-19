//
//  ParentViewModel.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 6/16/19.
//  Copyright (c) 2019 Ali Adam. All rights reserved.
//

import RxSwift
import Reachability
/// base ViewModel have some common  that may be used in all ViewModel
class ViewModel {

    // MARK: Variable
    let activityIndicatorSubject = BehaviorSubject<Bool>(value: false)
    let networkStatusDidChangeSubject = PublishSubject<Bool>()
    let errorSubject = PublishSubject<String>()

    init() {
      /// Listen to netowrk status
      ReachabilityManager.shared.addListener(listener: self)
    }

    /// get color for cell

    func handleError(error: Error) {
        print(error.localizedDescription)
        self.errorSubject.onNext(LocalizableWords.loadingDataError)
    }
}

// MARK: - Network Status Listener handler
extension ViewModel: NetworkStatusListener {
    func networkStatusDidChange(status: Reachability.Connection) {
        switch status {
        case .none:
            networkStatusDidChangeSubject.onNext(false)
        case .wifi:
            networkStatusDidChangeSubject.onNext(true)
        case .cellular:
            networkStatusDidChangeSubject.onNext(true)

        case .unavailable:
            networkStatusDidChangeSubject.onNext(false)

        }

    }
}
