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
    @Binding  var isOnSession: Bool
    //this is used to determine the current setup step for the progress bar
    private let setupStep: Float = 3
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ProgressView(value: setupVM.calculateProgress(currentStep: setupStep))
                    Text("Who are you interested in?").font(.headline)
                   
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
                .frame(width: .infinity)
            }
        }.navigationDestination(isPresented: $navActive, destination: {
            DisabilityStatusSetupView(setupVM: setupVM, showWelcome: $isOnSession)
        }).navigationTitle("Interested in Details").navigationBarTitleDisplayMode(.inline)
        
    }
}

struct InterestedInSetupView_Previews: PreviewProvider {
    static var previews: some View {
        InterestedInSetupView(setupVM: InitialSetupViewModel(), isOnSession: .constant(false))
    }
}
