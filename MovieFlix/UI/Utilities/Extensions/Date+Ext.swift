//
//  Date+Ext.swift
//  MovieFlix
//
//  Created by Doni on 18/02/23.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.day().month().year())
    }
}
