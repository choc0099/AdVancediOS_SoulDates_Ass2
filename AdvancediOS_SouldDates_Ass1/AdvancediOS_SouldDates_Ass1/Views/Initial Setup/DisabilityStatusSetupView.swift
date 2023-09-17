//
//  DisabilitySetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

//this is a setup view asking whether you have a disability.
//these will take to different navigation views accordingly.
struct DisabilityStatusSetupView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    @Binding var showWelcome: Bool
    let setupStep: Float = 4
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ProgressView(value: setupVM.calculateProgress(currentStep: setupStep))
                    Text("Do you have a disability?").font(.headline)
                    
                    NavigationLink {
                        DisabilityDetailsSetupView(setupVM: setupVM, isOnSession: $showWelcome)
                    } label: {
                        StyledButton(text: "Yes, I do", backGroundColour: .red, foregroundColour: .white)
                    }.padding()
                    
                    NavigationLink {
                        DatingPreferencesView(setupVM: setupVM, isOnSession: $showWelcome)
                    } label: {
                        StyledButton(text: "No, i don't", backGroundColour: .yellow, foregroundColour: .black)
                    }.padding()
                }.navigationTitle("Disability Status").navigationBarTitleDisplayMode(.inline)
            }.frame(maxWidth: .infinity) //optimizes scrolling when in landscape mode.
        }
    }
}

struct DisabilitySetupView_Previews: PreviewProvider {
    static var previews: some View {
        DisabilityStatusSetupView(setupVM: InitialSetupViewModel(), showWelcome: .constant(false))
    }
}
