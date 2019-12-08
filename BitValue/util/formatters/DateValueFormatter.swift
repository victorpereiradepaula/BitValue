//
//  DateValueFormatter.swift
//  BitValue
//
//  Created by Victor Pereira de Paula on 06/12/19.
//  Copyright © 2019 Victor Pereira. All rights reserved.
//

import Charts

public class DateValueFormatter: NSObject, IAxisValueFormatter {

    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
