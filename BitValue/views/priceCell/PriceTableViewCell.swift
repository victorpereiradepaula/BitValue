//
//  PriceTableViewCell.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

protocol PriceViewModelProtocol {
    var dateString: String { get }
    var valueString: String { get }
}

final class PriceTableViewCell: BaseTableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func applyLayout() {
        super.applyLayout()
        
        setupContainer(view: containerView)
        
        dateLabel.textColor = .white
        
        valueLabel.textColor = .white
    }
    
    func populate(with viewModel: PriceViewModelProtocol) {
        dateLabel.text = viewModel.dateString
        valueLabel.text = viewModel.valueString
    }
}
