//
//  Dateable.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 16/9/2023.
//

import Foundation

//the dateable protocol is a similar use case of a canFly protocol where it contains an Extension with methods to filter date ranges accross multiple structs.
protocol Dateable {
    
}

extension Dateable {
    static func futureDateRange() -> ClosedRange<Date> {
        let calendar = Calendar.current
        let calStartDateComp = calendar.dateComponents([.day, .month, .year], from: Date.now)
        let startingDate = DateComponents(year: calStartDateComp.year, month: calStartDateComp.month, day: calStartDateComp.day)
        let calEndDateComp = calendar.dateComponents([.day, .month, .year], from: Date.distantFuture)
        let endingDate = DateComponents(year: calEndDateComp.year, month: calEndDateComp.month, day: calEndDateComp.day)
        return calendar.date(from: startingDate)!
        ...
        calendar.date(from: endingDate)!
    }
    
    static func passedDateRange() -> ClosedRange<Date> {
        let calendar = Calendar.current
        let calStartDateComp = calendar.dateComponents([.day, .month, .year], from: Date.distantPast)
        let startingDate = DateComponents(year: calStartDateComp.year, month: calStartDateComp.month, day: calStartDateComp.year)
        let calEndDateComp = calendar.dateComponents([.day, .month, .year], from: Date.now)
        let endingDate = DateComponents(year: calEndDateComp.year, month: calEndDateComp.month, day: calEndDateComp.day)
        return calendar.date(from: startingDate)!
        ...
        calendar.date(from: endingDate)!
    }
}
