//
//  PriceTableViewCell.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    func populate(with viewModel: PriceViewModel) {
        dateLabel.text = viewModel.dateString
        valueLabel.text = viewModel.valueString
    }

    private func applyLayout() {
        
    }
}
