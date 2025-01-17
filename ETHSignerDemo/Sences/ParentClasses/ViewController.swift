//
//  ParentViewController.swift
//  ETHSignerDemo
//
//  Created by Ali Adam on 6/16/19.
//  Copyright (c) 2019 Ali Adam. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

/// Base contrroler   have some common methods that may be used in all screen
class ViewController: UIViewController {

    ///  hide NavigationBarHidden
    func hideNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    /// show NavigationBarHidden
    func showNavBar() {
        navigationController?.isNavigationBarHidden = false

    }

    func hideKeyBoard() {
        DispatchQueue.main.async {
        self.view.endEditing(true)
        }
    }

    /// show or hide Activaty Indicator
    func setActivatyIndicatorVisabilty(visable:Bool) {
        DispatchQueue.main.async {
        if visable {
            self.showActivaty()
        } else {
            self.hideActivity()
        }
        }
    }

    /// show Activaty Indicator
    private func showActivaty() {
        ActivityIndicator.shared.animateActivity(title: LocalizableWords.loading, navigationItem: self.navigationItem)

    }

    /// hide Activaty Indicator
    private func hideActivity() {
        ActivityIndicator.shared.stopAnimating(navigationItem: self.navigationItem)

    }

}

extension ViewController {
    /// show alert on controller
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        DispatchQueue.main.async {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { _ in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
        }
    }
}
