//
//  PriceValueFormatter.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 06/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Charts

final class PriceValueFormatter: NSObject, IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        String(format: "%.2f", value)
    }
}
