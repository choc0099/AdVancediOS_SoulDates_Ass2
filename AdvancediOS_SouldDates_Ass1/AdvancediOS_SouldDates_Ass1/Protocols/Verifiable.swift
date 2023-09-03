//
//  Verifiable.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import Foundation

//this protocol will be used for police checks, reference checks and proof of age idenficiation.
protocol Verifiable: Identifiable, Decodable {
    
    var expiryDate: Date {get set}
    var dateIssued: Date {get set}
    
}




