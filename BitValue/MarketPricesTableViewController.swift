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
        tableView.register(UINib(nibName: PriceTableViewCell.nibName, bundle: Bundle(for: PriceTableViewCell.self)), forCellReuseIdentifier: PriceTableViewCell.nibName)
    }
}

// MARK: - Table view data source
extension MarketPricesTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.nibName, for: indexPath) as! PriceTableViewCell
        cell.populate(with: viewModels[indexPath.row])
        return cell
    }
}
