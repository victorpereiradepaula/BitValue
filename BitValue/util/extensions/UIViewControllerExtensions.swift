//
//  UIViewControllerExtensions.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

protocol AlertViewModelProtocol {
    var title: String? { get }
    var message: String? { get }
    var alertActions: [UIAlertAction] { get }
}

extension UIViewController {

    func showAlert(alertViewModel: AlertViewModelProtocol) {
        let alertController = UIAlertController(title: alertViewModel.title, message: alertViewModel.message, preferredStyle: .alert)
        
        for alertAction in alertViewModel.alertActions {
            alertController.addAction(alertAction)
        }
        
        present(alertController, animated: true)
    }
}
