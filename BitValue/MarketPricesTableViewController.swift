//
//  MarketPricesTableViewController.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

class MarketPricesTableViewController: UITableViewController {
        
    let viewModels: [PriceViewModel] = [
        PriceViewModel(date: Date(), value: 7656.995),
        PriceViewModel(date: Date(), value: 7360.544166666667),
        PriceViewModel(date: Date(), value: 7307.416666666668),
        PriceViewModel(date: Date(), value: 7314.758333333335),
        PriceViewModel(date: Date(), value: 7288.243333333335)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .backgroundColor
        tableView.register(UINib(nibName: HighlightedPriceTableViewCell.nibName, bundle: Bundle(for: HighlightedPriceTableViewCell.self)), forCellReuseIdentifier: HighlightedPriceTableViewCell.nibName)
        tableView.register(UINib(nibName: PriceTableViewCell.nibName, bundle: Bundle(for: PriceTableViewCell.self)), forCellReuseIdentifier: PriceTableViewCell.nibName)
    }
}

// MARK: - Table view data source
extension MarketPricesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows: Int
        
        switch section {
        case 0:
            numberOfRows = 1
            
        case 1:
            numberOfRows = viewModels.count - 1
            
        default:
            numberOfRows = 0
        }
        
        return numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HighlightedPriceTableViewCell.nibName, for: indexPath) as! HighlightedPriceTableViewCell
             cell.populate(with: viewModels[0])
             return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.nibName, for: indexPath) as! PriceTableViewCell
             cell.populate(with: viewModels[indexPath.row + 1])
             return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - TODO
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
