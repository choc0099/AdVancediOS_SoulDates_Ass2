//
//  AbouteMeView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct AbouteMeView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @EnvironmentObject var session: Session
    @State var showAlert: Bool = false
    @State var navActive: Bool = false
    @State var buttonDisabled: Bool = true
    @State var borderColor: Color = .primary
    @Binding var isOnSession: Bool
    private let setupStep: Float = 7
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ProgressView(value: setupVM.calculateProgress(currentStep: setupStep))
                    Text("Enter a bio about yourself.")
                    TextEditor(text: $setupVM.bio).frame(height: 200).border(borderColor)
                    Text("What are your favourite hobbies?")
                    TextEditor(text: $setupVM.hobbies).frame(height: 100).border(borderColor)
                    Text("What is your favourite music?")
                    TextEditor(text: $setupVM.favouriteMusic).frame(height: 100).border(borderColor)
                    
                    Button {
                        do {
                            try setupVM.validateAboutMe()
                            //declare a constant to add a match seeker to the list
                            processData()
                            isOnSession = true // dismisses the welcome/setup full-screen sheet.
                        }
                        catch {
                            showAlert = true
                        }
                    } label: {
                        StyledButton(text: "Finish", backGroundColour: Color("GreenColour"), foregroundColour: .black)
                    }.padding().disabled(buttonDisabled)
                }.padding().navigationTitle("About Me").navigationBarTitleDisplayMode(.inline)
                    .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Some Text fields are not entered."),
                        message: Text("Please check your text fields.")
                    )
                }
            }.onChange(of: allTextEntered()) { everythingIsEneterd in
                if everythingIsEneterd {
                    buttonDisabled = false
                }
                else {
                    buttonDisabled = true
                }
            }
        }
    }
    
    func allTextEntered() -> Bool {
        if !setupVM.bio.isEmpty && !setupVM.hobbies.isEmpty && !setupVM.favouriteMusic.isEmpty {
            return true
        }
        else {
            return false
        }
    }
    
    func processData() {
        let matchseeker = setupVM.convertToObject()
        //saves the matchSeeker to the session
        SessionStorageManager.setMatchSeekerToUserDefaults(currentMatchSeeker: matchseeker)
        soulDatesMain.onboardMatchSeeker(matchSeeker: matchseeker)
        session.matchSeekerId = matchseeker.id
    }
}

struct AbouteMeView_Previews: PreviewProvider {
    static var previews: some View {
        //var matchSeeker = matchSeekersSample[0]
      
        Group {
            AbouteMeView(setupVM: InitialSetupViewModel(), isOnSession: .constant(false)).environmentObject(Session()).environmentObject(SoulDatesMain())
        }
       
    }
}
