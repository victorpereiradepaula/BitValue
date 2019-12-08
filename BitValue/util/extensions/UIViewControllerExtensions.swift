//
//  UIViewControllerExtensions.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 07/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(title: String?, message: String?, alertActions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for alertAction in alertActions {
            alertController.addAction(alertAction)
        }
        
        present(alertController, animated: true)
    }
}
