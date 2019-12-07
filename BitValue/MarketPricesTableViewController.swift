//
//  MarketPricesTableViewController.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

final class MarketPricesTableViewController: UITableViewController {
    
    let viewModels: [PriceViewModel] = [
        PriceViewModel(date: Date(timeIntervalSince1970: 1544054400), value: 7656.995),
        PriceViewModel(date: Date(timeIntervalSince1970: 1544400000), value: 7360.544166666667),
        PriceViewModel(date: Date(timeIntervalSince1970: 1544745600), value: 7307.416666666668),
        PriceViewModel(date: Date(timeIntervalSince1970: 1545091200), value: 7314.758333333335),
        PriceViewModel(date: Date(timeIntervalSince1970: 1545436800), value: 7288.243333333335)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableView()
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.title = "Cotação do Bitcoin"
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        rightBarButtonItem.tintColor = .orange
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .backgroundColor
        tableView.register(UINib(nibName: HighlightedPriceTableViewCell.nibName, bundle: Bundle(for: HighlightedPriceTableViewCell.self)), forCellReuseIdentifier: HighlightedPriceTableViewCell.nibName)
        tableView.register(UINib(nibName: MarketPricesChartTableViewCell.nibName, bundle: Bundle(for: MarketPricesChartTableViewCell.self)), forCellReuseIdentifier: MarketPricesChartTableViewCell.nibName)
        tableView.register(UINib(nibName: PriceTableViewCell.nibName, bundle: Bundle(for: PriceTableViewCell.self)), forCellReuseIdentifier: PriceTableViewCell.nibName)
    }
    
    // MARK: - TODO
//    private func setupTableViewHeader(title: String) -> UIView {
//        let label = UILabel()
//        label.text = title
//        label.textColor = .orange
//        label.backgroundColor = .black
//        label.inset
//        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        return label
//    }
    
    @objc private func refreshData() {
        
    }
}

// MARK: - Table view data source
extension MarketPricesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows: Int
        
        switch section {
        case 0, 1:
            numberOfRows = 1
            
        case 2:
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
            let cell = tableView.dequeueReusableCell(withIdentifier: MarketPricesChartTableViewCell.nibName, for: indexPath) as! MarketPricesChartTableViewCell
            cell.populate(with: viewModels)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.nibName, for: indexPath) as! PriceTableViewCell
            cell.populate(with: viewModels[indexPath.row + 1])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - TODO
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch section {
//        case 0:
//            return setupTableViewHeader(title: "Última cotação")
//            
//        case 1:
//            return setupTableViewHeader(title: "Cotaão média dos últimos 7 dias")
//            
//        case 2:
//            return setupTableViewHeader(title: "Mais cotações")
//        default:
//            return nil
//        }
//    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
