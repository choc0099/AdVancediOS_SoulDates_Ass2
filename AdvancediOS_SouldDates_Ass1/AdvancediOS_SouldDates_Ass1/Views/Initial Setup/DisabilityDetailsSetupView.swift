//
//  DisabilityDetailsSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 2/9/2023.
//

import SwiftUI

struct DisabilityDetailsSetupView: View {
    @Binding var dateOfBirth: Date
    @Binding var screenName: String
    @Binding var gender: Gender
    @Binding var interestedIn: InterestedIn
    
    
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DisabilityDetailsSetupView_Previews: PreviewProvider {
    static var previews: some View {
        DisabilityDetailsSetupView(dateOfBirth: .constant(Date.now), screenName: .constant("Choke"), gender: .constant(.male), interestedIn: .constant(.women))
    }
}
