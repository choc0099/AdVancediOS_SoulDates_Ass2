//
//  Verifiable.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import Foundation

//this protocol will be used for police checks, reference checks and proof of age idenficiation.
protocol Verifiable: Identifiable {
    
    var expiryDate: Date {get set}
    var dateIssued: Date {get set}
    
}

extension Verifiable {
    static func expiryDateRange() -> ClosedRange<Date> {
        let calendar = Calendar.current
        let calStartDateComp = calendar.dateComponents([.day, .month, .year], from: Date.now)
        let startingDate = DateComponents(year: calStartDateComp.year, month: calStartDateComp.month, day: calStartDateComp.day)
        let calEndDateComp = calendar.dateComponents([.day, .month, .year], from: Date.distantFuture)
        let endingDate = DateComponents(year: calEndDateComp.year, month: calEndDateComp.month, day: calEndDateComp.day)
        return calendar.date(from: startingDate)!
        ...
        calendar.date(from: endingDate)!
    }
    
    static func issuedDateRange() -> ClosedRange<Date> {
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




