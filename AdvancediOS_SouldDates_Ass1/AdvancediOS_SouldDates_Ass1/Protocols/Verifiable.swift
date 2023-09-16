//
//  Verifiable.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import Foundation

//the verifiable protocol is used for multiple types of background checks including police checks, referee checks and proof of age identification. They both have an issueDate and expiryDate properties
protocol Verifiable: Identifiable, Dateable {
    var expiryDate: Date {get set}
    var dateIssued: Date {get set}
}





