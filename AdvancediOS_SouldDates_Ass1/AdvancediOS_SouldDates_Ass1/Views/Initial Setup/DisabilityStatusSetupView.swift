//
//  DisabilitySetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct DisabilityStatusSetupView: View {
    @Binding var dateOfBirth: Date
    @Binding var screenName: String
    @Binding var gender: Gender
    @Binding var interestedIn: InterestedIn
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Do you have a disability?")
                
                NavigationLink {
                    DisabilityDetailsSetupView(dateOfBirth: $dateOfBirth, screenName: $screenName, gender: $gender, interestedIn: $interestedIn)
                } label: {
                    Text("Yes, I do")
                }.padding()
                
                NavigationLink {
                    DatingPreferencesView()
                } label: {
                    Text("No, i don't")
                }.padding()
            }
        }
                
    }
}

struct DisabilitySetupView_Previews: PreviewProvider {
    static var previews: some View {
        DisabilityStatusSetupView(dateOfBirth: .constant(Date.now), screenName: .constant("Choke"), gender: .constant(.male), interestedIn: .constant(.women))
    }
}
