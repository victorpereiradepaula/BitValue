//
//  HighlightedPriceTableViewCell.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

protocol HighlightedPriceViewModelProtocol {
    var completeDateString: String { get }
    var unit: String { get }
    var valueString: String { get }
}

final class HighlightedPriceTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func applyLayout() {
        super.applyLayout()
        
        setupContainer(view: containerView)
        
        dateLabel.textColor = .white
        
        unitLabel.textColor = .orange
        unitLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        
        valueLabel.textColor = .white
        valueLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
    }
    
    func populate(with viewModel: HighlightedPriceViewModelProtocol) {
        dateLabel.text = viewModel.completeDateString
        unitLabel.text = viewModel.unit
        valueLabel.text = viewModel.valueString
    }
}
