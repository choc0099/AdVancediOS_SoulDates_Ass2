//
//  InterestedInSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 2/9/2023.
//

import SwiftUI

struct InterestedInSetupView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    @State private var navActive: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Who are you interested in?").padding()
                   
                    ForEach(InterestedIn.allCases) {
                         interestedIn in
                        Button {
                            navActive = true
                            setupVM.interestedIn = interestedIn
                          
                        } label: {
                            StyledButton(text: interestedIn.rawValue.capitalized, backGroundColour: .blue, foregroundColour: .black)
                        }.padding()
                    }
                }
            }
        }.navigationDestination(isPresented: $navActive, destination: {
            DisabilityStatusSetupView(setupVM: setupVM)
        }).navigationTitle("Interested in Details")
        
    }
}

struct InterestedInSetupView_Previews: PreviewProvider {
    static var previews: some View {
        InterestedInSetupView(setupVM: InitialSetupViewModel())
    }
}
