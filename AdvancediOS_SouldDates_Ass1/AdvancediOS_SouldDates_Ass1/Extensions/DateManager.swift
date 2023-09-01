//
//  DateManager.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 31/8/2023.
//

import Foundation

class DateManager {
    
    
    //this will be a helper function for sample objects at this stage.
    static func setDate(day: Int, month: Int, year: Int) -> Date? {
        var dateComp = DateComponents()
        dateComp.day = day
        dateComp.month = month
        dateComp.year = year
        
        //creates the date via the calandar
        let cal = Calendar(identifier: .gregorian)
        return cal.date(from: dateComp)
    }
    
    //a helper function that will be used to validate birthdate so only over 18's can join
    static public func isUnderAge(birthDate: Date) -> Bool {
        
        if let minAgeToAccess: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date.now)
        {
            if birthDate > minAgeToAccess {
                return true
            }
        }
        return false
    }
    
}
