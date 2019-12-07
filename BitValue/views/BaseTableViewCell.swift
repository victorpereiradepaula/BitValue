//
//  BaseTableViewCell.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }

    open func applyLayout() {
        backgroundColor = .clear
    }
    
    open func setupContainer(view: UIView) {
        view.backgroundColor = .black
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
    }
}
