//
//  AlertViewModel.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 08/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

struct AlertViewModel: AlertViewModelProtocol {
    let title: String?
    let message: String?
    let alertActions: [UIAlertAction]
    
    init(title: String?, message: String?, alertActions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]) {
        self.title = title
        self.message = message
        self.alertActions = alertActions
    }
}
