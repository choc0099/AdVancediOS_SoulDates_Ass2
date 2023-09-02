//
//  DisabilityDetailsSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 2/9/2023.
//

import SwiftUI

struct DisabilityDetailsSetupView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    @State private var navActive: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("What is your disabilities?").padding()
                TextField("Your disabilities", text: $setupVM.disability).padding()
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
                Button("Next", action: {
                    do {
                        navActive = true
                        try setupVM.validateDisability()
                    }
                    catch {
                        showAlert = true
                    }
                }).alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Text fields not entered"),
                        message: Text("Please enter details about your disability.")
                    )
                }
            }
        }.padding().navigationDestination(isPresented: $navActive) {
            DatingPreferencesView(setupVM: setupVM)
        }
    }
}
        
    


struct DisabilityDetailsSetupView_Previews: PreviewProvider {
    static var previews: some View {
        DisabilityDetailsSetupView(setupVM: InitialSetupViewModel())
    }
}
