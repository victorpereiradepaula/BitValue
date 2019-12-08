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
    
    private let headerHeight: CGFloat = 50
    private let marketPricesViewModel: MarketPricesTableViewControllerProtocol
    
    init(marketPricesViewModel: MarketPricesTableViewControllerProtocol) {
        self.marketPricesViewModel = marketPricesViewModel
        super.init(style: UITableView.Style.grouped)
    }
    
    required init?(coder: NSCoder) {
        self.marketPricesViewModel = MarketPricesViewModel()
        super .init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupTableView()
        
        // MARK: - TODO: adicionar quando não carregar nenhum dado ou em caso de erro
//        let reloadAction = UIAlertAction(title: "Tentar novamente", style: .default) { [weak self] _ in
//            self?.reloadData()
//        }
//        let okAction = UIAlertAction(title: "OK", style: .cancel)
//
//        showAlert(title: "Falha ao carregar os dados", message: "Contate o suporte caso o problema persista.", alertActions: [reloadAction, okAction])
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.title = "Cotação do Bitcoin"
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        rightBarButtonItem.tintColor = .orange
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .backgroundColor
        tableView.register(UINib(nibName: HighlightedPriceTableViewCell.nibName, bundle: Bundle(for: HighlightedPriceTableViewCell.self)), forCellReuseIdentifier: HighlightedPriceTableViewCell.nibName)
        tableView.register(UINib(nibName: MarketPricesChartTableViewCell.nibName, bundle: Bundle(for: MarketPricesChartTableViewCell.self)), forCellReuseIdentifier: MarketPricesChartTableViewCell.nibName)
        tableView.register(UINib(nibName: PriceTableViewCell.nibName, bundle: Bundle(for: PriceTableViewCell.self)), forCellReuseIdentifier: PriceTableViewCell.nibName)
    }
    
    private func setupHeaderView(at section: Int) -> UIView {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight))
        headerView.backgroundColor = .black
        
        let labelLeftMargin: CGFloat = 16
        
        let titleLabel = UILabel(frame: CGRect(x: labelLeftMargin, y: 0, width: headerView.frame.width - labelLeftMargin, height: headerHeight))
        titleLabel.textColor = .orange
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = marketPricesViewModel.headerTitle(at: section)

        headerView.addSubview(titleLabel)
        return headerView
    }
    
    @objc private func reloadData() {
            // MARK: - TODO
    }
}

// MARK: - Table view data source
extension MarketPricesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        marketPricesViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        marketPricesViewModel.numberOfRows(at: section)
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        setupHeaderView(at: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        headerHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
