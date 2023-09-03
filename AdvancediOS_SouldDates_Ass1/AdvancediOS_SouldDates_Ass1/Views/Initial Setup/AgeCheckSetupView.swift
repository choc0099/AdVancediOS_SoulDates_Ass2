//
//  AgeCheckSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct AgeCheckSetupView: View {
    
    @ObservedObject var setupVM: InitialSetupViewModel
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startingDate = DateComponents(year: 1900, month: 1, day: 1)
        let calDateComp = calendar.dateComponents([.day, .month, .year], from: Date.now)
        let endingDate = DateComponents(year: calDateComp.year, month: calDateComp.month, day: calDateComp.day)
        return calendar.date(from: startingDate)!
        ...
        calendar.date(from: endingDate)!
        
    }()
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var navActive: Bool = false
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                Text("Enter your screen name:")
                TextField (
                    "Name",
                    text: $setupVM.screenName
                ).textInputAutocapitalization(.never).padding().border(.black)
                Divider()
                Text("Date of Birth")
                DatePicker("", selection: $setupVM.dateOfBirth, in: dateRange, displayedComponents: [.date]).datePickerStyle(.wheel)
                
                    Button {
                        do {
                            try setupVM.validateBasicDetails()
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
                    } label: {
                        StyledButton(text: "Next", backGroundColour: .green, foregroundColour: .black)
                    }.padding()
            }
            
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("\(alertTitle)"),
                message: Text("\(alertMessage)")
            )
        }.padding().navigationDestination(isPresented: $navActive) {
            GenderSetupView(setupVM: setupVM)
        }
        
    }
}

struct AgeCheckSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AgeCheckSetupView(setupVM: InitialSetupViewModel())
           
    }
}
