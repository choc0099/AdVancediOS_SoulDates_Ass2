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
            
            Button("Next", action: {
                do {
                    try validate(dateOfBirth: dateOfBirth, screenName: screeName)
                    print("Pressed")
                
                }
                catch ProfileError.underAgeException {
                    showAlert = true
                }
                catch {
                    print("Invalid input")
                }
             
            }).alert(isPresented: $showAlert) {
                Alert(
                    title: Text("You are under age!"),
                    message: Text("You must be over 18 years old to use the dating app.")
                )
            }
        }.padding()
        
    }
    
    func validate(dateOfBirth: Date, screenName: String) throws {
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
