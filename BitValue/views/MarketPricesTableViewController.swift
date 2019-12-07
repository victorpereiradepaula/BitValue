//
//  MarketPricesTableViewController.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 05/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit

protocol MarketPricesTableViewControllerProtocol {
    
    var sections: [[PriceViewModel]] { get }
    var numberOfSections: Int { get }
    
    func numberOfRows(at section: Int) -> Int
    func headerTitle(at section: Int) -> String?
}

final class MarketPricesTableViewController: UITableViewController {
    
    let marketPricesViewModel: MarketPricesTableViewControllerProtocol
    
    init(marketPricesViewModel: MarketPricesTableViewControllerProtocol) {
        self.marketPricesViewModel = marketPricesViewModel
        super.init(style: UITableView.Style.grouped)
    }
    
    required init?(coder: NSCoder) {
        self.marketPricesViewModel = MarketPricesViewModel(pricesViewModels: [])
        super .init(coder: coder)
    }
    
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
    private func setupTableViewHeader(title: String?) -> UIView {
        let label = UILabel()
        label.text = title
        label.textColor = .orange
        label.backgroundColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }
    
    @objc private func refreshData() {
        
    }
}

// MARK: - Table view data source
extension MarketPricesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return marketPricesViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketPricesViewModel.numberOfRows(at: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HighlightedPriceTableViewCell.nibName, for: indexPath) as? HighlightedPriceTableViewCell else { return UITableViewCell() }
            cell.populate(with: marketPricesViewModel.sections[indexPath.section][indexPath.row])
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketPricesChartTableViewCell.nibName, for: indexPath) as? MarketPricesChartTableViewCell else { return UITableViewCell() }
            cell.populate(with: marketPricesViewModel.sections[indexPath.section])
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.nibName, for: indexPath) as? PriceTableViewCell else { return UITableViewCell() }
            cell.populate(with: marketPricesViewModel.sections[indexPath.section][indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    // MARK: - TODO
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTitle = marketPricesViewModel.headerTitle(at: section)
        return setupTableViewHeader(title: headerTitle)
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
