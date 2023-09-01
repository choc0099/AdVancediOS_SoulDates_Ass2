//
//  AgeCheckSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct AgeCheckSetupView: View {
    
    @State private var screeName: String = ""
    @State private var dateOfBirth: Date = Date.now
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var navActive: Bool = false
    
    var body: some View {
        NavigationStack() {
            Text("Enter your name:")
            TextField (
                "Name",
                text: $screeName
            )
            Divider()
            Text("Date of Birth")
            DatePicker("", selection: $dateOfBirth, displayedComponents: [.date]).datePickerStyle(.wheel)
            NavigationLink( destination: BasicDetailsSetupView(dateOfBirth: $dateOfBirth, screenName: $screeName), isActive: $navActive) {
                Button("Next", action: {
                    do {
                        try validate(dateOfBirth: dateOfBirth, screenName: screeName)
                        navActive = true
                    }
                    catch ProfileError.underAgeException {
                        showAlert = true
                        alertTitle = "You are under age!"
                        alertMessage = "You must be over 18 years old to use the dating app."
                    }
                    catch {
                        showAlert = true
                        alertTitle = "Name field is empty"
                        alertMessage = "Please enter your screen name."
                    }
                }).padding()
            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("\(alertTitle)"),
                message: Text("\(alertMessage)")
            )
        }
        
    }
    
    func validate(dateOfBirth: Date, screenName: String) throws {
        guard (!screenName.isEmpty) else {
             throw ProfileError.emptyTextFields
        }
        guard !DateManager.isUnderAge(birthDate: dateOfBirth)
        else {
            throw ProfileError.underAgeException
        }
    }
}

struct AgeCheckSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AgeCheckSetupView()
    }
}
