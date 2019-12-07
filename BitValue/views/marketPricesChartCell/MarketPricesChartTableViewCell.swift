//
//  MarketPricesChartTableViewCell.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 06/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import UIKit
import Charts

protocol PriceChartViewModelProtocol {
    var timeInterval: TimeInterval { get }
    var value: Double { get }
}

final class MarketPricesChartTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func applyLayout() {
        super.applyLayout()
        
        setupContainer(view: containerView)
        
        let xAxis = lineChartView.xAxis
        xAxis.valueFormatter = DateValueFormatter()
        xAxis.labelTextColor = .white
        
        let leftAxis = lineChartView.leftAxis
        leftAxis.valueFormatter = PriceValueFormatter()
        leftAxis.labelTextColor = .white
        
        lineChartView.rightAxis.enabled = false
        lineChartView.setScaleEnabled(false)
        
        lineChartView.legend.textColor = .white
    }
    
    func populate(with viewModels: [PriceChartViewModelProtocol]) {
        var lineChartDataEntry: [ChartDataEntry] = []
        
        for viewModel in viewModels {
            let chartDataEntry = ChartDataEntry(x: viewModel.timeInterval, y: viewModel.value)
            lineChartDataEntry.append(chartDataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(entries: lineChartDataEntry, label: "Valor")
        lineChartDataSet.setCircleColor(.clear)
        lineChartDataSet.setColor(.orange)
        lineChartDataSet.valueColors = [.white]
        
        let lineChartData = LineChartData()
        lineChartData.addDataSet(lineChartDataSet)
        
        lineChartView.data = lineChartData
    }
}
