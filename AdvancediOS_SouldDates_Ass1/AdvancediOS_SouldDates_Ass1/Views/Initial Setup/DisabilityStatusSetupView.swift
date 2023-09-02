//
//  DisabilitySetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct DisabilityStatusSetupView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Do you have a disability?")
                
                NavigationLink {
                    DisabilityDetailsSetupView(setupVM: setupVM)
                } label: {
                    Text("Yes, I do")
                }.padding()
                
                NavigationLink {
                    DatingPreferencesView(setupVM: setupVM)
                } label: {
                    Text("No, i don't")
                }.padding()
            }.navigationTitle("Disability Status")
        }
                
    }
}

struct DisabilitySetupView_Previews: PreviewProvider {
    static var previews: some View {
        DisabilityStatusSetupView(setupVM: InitialSetupViewModel())
    }
}
