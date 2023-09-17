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
    let setupStep: Float = 5
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ProgressView(value: setupVM.calculateProgress(currentStep: setupStep))
                    Text("What is your disabilities?").padding()
                    TextField("Your disabilities", text: $setupVM.disability).padding().border(.primary).onChange(of: !setupVM.disability.isEmpty) { isEntered in
                        //button no longer disables when they entered this required field.
                        if isEntered {
                            buttonDisabled = false
                        }
                        else {
                            buttonDisabled = true
                        }
                    }
                    Divider()
                    Text("How Severe is your disability?").padding()
                    Picker("Severity", selection: $setupVM.disabilitySeverity) {
                        ForEach(DisabilitySeverity.allCases) {
                            severity in
                            Text(severity.rawValue.capitalized)
                        }
                    }.pickerStyle(.segmented).padding()
                    Toggle("Disclose my disability:", isOn: $setupVM.discloseMyDisability)
                    Text("Shows your disability status on your profile").font(.caption)
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
                    }.disabled(buttonDisabled)
                }
            }
        }.padding().navigationDestination(isPresented: $navActive) {
            DatingPreferencesView(setupVM: setupVM, isOnSession: $isOnSession)
        }.navigationTitle("Disability Details").alert(isPresented: $showAlert) {
            Alert(
                title: Text("Text fields not entered"),
                message: Text("Please enter details about your disability.")
            )
        }.onAppear{
            //checks whether the button should be disabled or not
            //this is used if the back button is pressed to update a previous screen.
            buttonDisabled = !setupVM.disability.isEmpty ? false : true
        }
    }
}
        
    


struct DisabilityDetailsSetupView_Previews: PreviewProvider {
    static var previews: some View {
        DisabilityDetailsSetupView(setupVM: InitialSetupViewModel(), isOnSession: .constant(false))
    }
}
