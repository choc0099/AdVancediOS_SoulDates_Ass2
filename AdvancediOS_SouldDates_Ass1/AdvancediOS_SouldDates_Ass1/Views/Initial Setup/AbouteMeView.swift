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
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Text("Enter a bio about yourself.")
                    TextEditor(text: $setupVM.bio).frame(height: 200).border(.black)
                    Text("What are your favourite hobbies?")
                    TextEditor(text: $setupVM.hobbies).frame(height: 100).border(.black)
                    Text("What is your favourite music?")
                    TextEditor(text: $setupVM.favouriteMusic).frame(height: 100).border(.black)
                    
                    Button {
                        do {
                            try setupVM.validateAboutMe()
                            //declare a constant to add a match seeker to the list
                            processData()
                            navActive = true
                        }
                        catch {
                            showAlert = true
                        }
                    } label: {
                        StyledButton(text: "Finish", backGroundColour: .green, foregroundColour: .black)
                    }.padding().disabled(buttonDisabled)
                }.padding().navigationTitle("About Me").alert(isPresented: $showAlert) {
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
        }.navigationDestination(isPresented: $navActive) {
            InSessionTabView()
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
        soulDatesMain.onboardMatchSeeker(matchSeeker: matchseeker)
        session.matchSeeker = matchseeker
    }
}

struct AbouteMeView_Previews: PreviewProvider {
    static var previews: some View {
        //var matchSeeker = matchSeekersSample[0]
        AbouteMeView(setupVM: InitialSetupViewModel())
    }
}
