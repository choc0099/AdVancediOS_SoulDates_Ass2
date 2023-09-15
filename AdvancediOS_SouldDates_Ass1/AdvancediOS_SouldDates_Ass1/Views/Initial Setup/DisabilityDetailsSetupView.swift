//
//  DisabilityDetailsSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 2/9/2023.
//

import SwiftUI

struct DisabilityDetailsSetupView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    @Binding var isOnSession: Bool
    @State private var navActive: Bool = false
    @State private var showAlert: Bool = false
    @State private var buttonDisabled: Bool = false
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack {
                    Text("What is your disabilities?").padding()
                    TextField("Your disabilities", text: $setupVM.disability).padding().border(.primary)
                    Divider()
                    Text("How Severe is your disability?").padding()
                    
                    Picker("", selection: $setupVM.disabilitySeverity) {
                        ForEach(DisabilitySeverity.allCases) {
                            severity in
                            Text(severity.rawValue.capitalized)
                        }
                    }.pickerStyle(.segmented).padding()
                    Toggle("Disclose my disability:", isOn: $setupVM.discloseMyDisability)
                    Spacer()
                    Button {
                        do {
                            navActive = true
                            setupVM.isDisabled = true
                            try setupVM.validateDisability()
                        }
                        catch {
                            showAlert = true
                        }
                    } label: {
                        StyledButton(text: "Next", backGroundColour: .green, foregroundColour: .black)
                    }
                    
                    
                }
            }
        }.padding().navigationDestination(isPresented: $navActive) {
            DatingPreferencesView(setupVM: setupVM, isOnSession: $isOnSession)
        }.navigationTitle("Disability Details").alert(isPresented: $showAlert) {
            Alert(
                title: Text("Text fields not entered"),
                message: Text("Please enter details about your disability.")
            )
        }
    }
}
        
    


struct DisabilityDetailsSetupView_Previews: PreviewProvider {
    static var previews: some View {
        DisabilityDetailsSetupView(setupVM: InitialSetupViewModel(), isOnSession: .constant(false))
    }
}
