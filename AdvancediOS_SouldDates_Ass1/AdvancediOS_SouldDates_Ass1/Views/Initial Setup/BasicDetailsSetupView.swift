//
//  AgeCheckSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct BasicDetailsSetupView: View {
   
    @ObservedObject var setupVM: InitialSetupViewModel
    @Binding var isOnSession: Bool
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var navActive: Bool = false
    @State private var buttonDisabled: Bool = false
    //this is a constant that is allocated for this currentView step
    let setupStep: Float = 1
    
    var body: some View {
        NavigationStack() {
            ScrollView {
                VStack(spacing: 20) {
                    ProgressView(value: setupVM.calculateProgress(currentStep: setupStep))
                    Text("Enter your screen name:")
                    TextField (
                        "Name",
                        text: $setupVM.screenName
                    ).autocorrectionDisabled(true).textInputAutocapitalization(.never).padding().border(Color("HighContrastForeground")).onChange(of: setupVM.screenName) { screenName in
                        if  screenName.count > 0 {
                            buttonDisabled = false
                        }
                        else {
                            buttonDisabled = true
                        }
                    }
                    
                    DatePicker("Date of birth:", selection: $setupVM.dateOfBirth, in: MatchSeeker.passedDateRange(), displayedComponents: [.date]).datePickerStyle(.automatic).textContentType(.dateTime)
                    Spacer(minLength: 10)
                    Divider()
                    Group {
                        Text("Minimum Age Range:")
                        Stepper("\(setupVM.minAge)", value: $setupVM.minAge, in: 18...100)
                        Text("Maximum Age Range")
                        Stepper("\(setupVM.maxAge)", value: $setupVM.maxAge, in: 18...100)
                        Text("This is the age ranges when it comes to looking for a matchSeeker?").font(.caption)
                    }
                   
                    Button {
                            do {
                                //checks for date of birth if it is under age.
                                //only people over 18 can use this app.
                                try setupVM.validateBasicDetails()
                                //navigates to the next screen
                                navActive = true
                            }
                            catch ProfileError.underAgeException {
                                showAlert       = true
                                alertTitle      = "You are under age!"
                                alertMessage    = "You must be over 18 years old to use the dating app."
                            }
                            catch {
                                showAlert = true
                                alertTitle = "Name field is empty"
                                alertMessage = "Please enter your screen name."
                            }
                    } label: {
                        StyledButton(text: "Next", backGroundColour: Color("GreenColour"), foregroundColour: .black)
                        }.padding().disabled(buttonDisabled)
                }.frame(maxWidth: .infinity) //optimizes scrolling when in landscape mode.
            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text("\(alertTitle)"),
                message: Text("\(alertMessage)")
            )
        }.padding().navigationDestination(isPresented: $navActive) {
            GenderSetupView(setupVM: setupVM, showWelcome: $isOnSession)
        }.navigationTitle("Basic Details").navigationBarTitleDisplayMode(.inline).onAppear {
            buttonDisabled = setupVM.screenName.count > 0 ? false: true
        }
        
    }
}

struct AgeCheckSetupView_Previews: PreviewProvider {
    static var previews: some View {
        BasicDetailsSetupView(setupVM: InitialSetupViewModel(), isOnSession: .constant(false))
           
    }
}
