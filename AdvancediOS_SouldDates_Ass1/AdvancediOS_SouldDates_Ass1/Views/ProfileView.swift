//
//  ProfileView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 19/8/2023.
//

import SwiftUI

struct ProfileView: View {
    //@ObservedObject var profileVM = ProfileViewModel()
    @State var matchSeeker: MatchSeeker
    @EnvironmentObject var session: Session
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @Binding var selectedTab: Tab
    @State private var showActionSheet: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    //these are for the actionsheet buttons based on different scenarios
    //for example, if the match seeker is already added to a dreamlist,
    //it will dispaly "Remove from DreamList" instead of "Add to DreamList"
    @State private var scammerStatus: String = ""
    @State private var dreamListStatus: String = ""
    //this is the constants that will store a system image names
    private let scamIcon: String = "exclamationmark.triangle.fill"
    private let backgroundCheckIcon: String = "checkmark.seal"
    //these are the colors being used for background check and scammer status using a custom text view
    private let scammerBackgroundColour: Color = Color(red: 0.93, green: 0.294, blue: 0.17)
    private let backgroundCheckBackgroundColour: Color =  Color("GreenColour")
    private let backgroundCheckForegroundColour: Color = Color("HighContrastForegroundColour")
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    //this is where you would see the profile iamge
                    ProfileImageView(matchSeekerImage: matchSeeker.imageName, imageSize: 250)
                    //let matchSeeker = profileVM.matchSeeker
                    Group {
                        Text("\(matchSeeker.screenName)").font(.title2).fontWeight(.bold)
                        if let haveDisability = matchSeeker.getHeadlineText() {
                             Text(haveDisability).font(.subheadline)
                        }
                        
                        //displays the age of the match seeker
                        Text("Age: \(DateManager.calculateAge(birthDate: matchSeeker.dateOfBirth))")
                    }
                    Spacer()
                    //a group of text relating to background check statues
                    Group {
                        if !matchSeeker.isScammer {
                            if let haveBackgroundCheck = matchSeeker.backgroundCheck {
                                if haveBackgroundCheck.policeCheck != nil {
                                    BackgroundCheckStatusView(text: "This match seeker has been policed checked", backgroundColor: backgroundCheckBackgroundColour, foregroundColor: backgroundCheckForegroundColour, systemIconName: backgroundCheckIcon)
                                }
                                if haveBackgroundCheck.proofOfAge != nil {
                                    BackgroundCheckStatusView(text: "This match seeker has been verified as a real person.", backgroundColor: backgroundCheckBackgroundColour, foregroundColor: backgroundCheckForegroundColour, systemIconName: backgroundCheckIcon)
                                }
                                if haveBackgroundCheck.refereeCheck != nil {
                                    BackgroundCheckStatusView(text: "This match seeker has been referee checked", backgroundColor: backgroundCheckBackgroundColour, foregroundColor: backgroundCheckForegroundColour, systemIconName: backgroundCheckIcon)
                                }
                            }
                        }
                    }
                    
                    //checks if it has been reported as a scammer.
                    if matchSeeker.isScammer {
                        BackgroundCheckStatusView(text: "This match seeker was known to be a scammer.", backgroundColor: scammerBackgroundColour, foregroundColor: .white, systemIconName: scamIcon)
                    }
                    Text("Gender: \(matchSeeker.gender.rawValue.capitalized)")
                    Group {
                        Text("Bio").font(.headline).padding()
                        Text("\(matchSeeker.bio)").font(.body)
                        Text("Hobbies").font(.headline).padding()
                        Text(matchSeeker.hobbies).padding()
                        Text("Favourite Music").padding()
                        Text("\(matchSeeker.favouriteMusic)").padding()
                    }
                }
                
                //according to my UI Design, the connect button is used to sent a connection request to a match seeker.
                //for the purpose of this prototype, there will be no API communications, therefore an alert will show.
                //that the feature is still in development.
                Button {
                   //shows an alert to a user that the app is a prototype
                    showAlert = true
                    alertTitle = "Under Construction!"
                    alertMessage = "This app is currently a prototype and does not have access to API's, we are still working on this feature."
                } label: {
                    StyledButton(text: "Connect", backGroundColour: backgroundCheckBackgroundColour, foregroundColour: Color("HighContrastForeground"))
                }
                
            }.padding().frame(maxWidth: .infinity)
        }.toolbar {
            Button {
                showActionSheet = true
            } label: {
                Image(systemName: "ellipsis.circle")
            }.accessibilityLabel(Text("More Options"))
        }.actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("What do you want to do with this MatchSeeker?"), buttons: [
                .default(Text(dreamListStatus)) {
                    handleDreamList()
                },
                .default(Text(scammerStatus)) {
                    do {
                        //updates it on the backend side
                        try soulDatesMain.toggleMatchSeekerScammer(currentMatchSeeker: matchSeeker)
                        //imdediately updates it to the view side.
                        matchSeeker.toggleScammer()
                        //refreshes the matchSeekers in SessionView.
                        session.gatherMatches(soulDatesMain: soulDatesMain)
                        //saves the scammer status to user defaults
                        try session.overWriteMatchSeekertoUserDefautls(soulDatesMain: soulDatesMain)
                        //updates the label of the report scam button.
                        checkScamStatus()
                    }
                    catch {
                        showAlert = true
                        alertTitle = "An error has occurred."
                    }
                },
                .cancel()
            ])
        }.onAppear{
            //calls a function to check if the match seeker is a scammer.
            checkScamStatus()
            //checks if matchSeeker is already added to the dreamList
            if session.checkAlreadyAdded(selectedMatchSeeker: matchSeeker)
            {
                dreamListStatus = "Remove from DreamList"
            }
            else {
                dreamListStatus = "Add to DreamList"
            }
        }.alert(isPresented: $showAlert) {
            Alert(
                title:
                    Text(alertTitle),
                message: Text(alertMessage)
            )
        }
    }
    
    func checkScamStatus() {
        //checks if a matchSeeker is a scammer
        if matchSeeker.isScammer {
            scammerStatus = "Cancel Report Scam"
        }
        else {
            scammerStatus = "Report Scam"
        }
    }
    
    //adds or remove a matchseeker from the dreamList.
    func handleDreamList() {
        do {
            if !session.checkAlreadyAdded(selectedMatchSeeker: matchSeeker) {
                session.addToDreamList(matchSeeker: matchSeeker)
                showAlert = true
                alertTitle = "Match Seeker Added!"
                alertMessage = "Match Seeker added to Dream List."
            }
            else {
                try session.removeFromDreamList(matchSeeker: matchSeeker)
                showAlert = true
                alertTitle = "Match Seeker Removed!"
                alertMessage = "Match Seeker removed from Dream List."
            }
        }
        catch {
            showAlert = true
            alertTitle = "Something went wrong!"
            alertMessage = "Unable to remove from Dream List."
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(matchSeeker: matchSeekersSample[1], selectedTab: .constant(.look) ).environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}
