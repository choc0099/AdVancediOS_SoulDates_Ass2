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
    @State private var dreamListStatus: String = ""
    //this is the constants that will store a system image names
    private let scamIcon: String = "exclamationmark.triangle.fill"
    private let backgroundCheckIcon: String = "checkmark.seal"
    //these are the colors being used for background check and scammer status using a custom text view
    private let scammerBackgroundColour: Color = .red
    private let backgroundCheckBackgroundColour: Color =  Color("GreenColour")
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ProfileImageView(matchSeekerImage: matchSeeker.imageName, imageSize: 250)
                    //let matchSeeker = profileVM.matchSeeker
                    Group {
                        Text("\(matchSeeker.screenName)").font(.title2).fontWeight(.bold)
                        
                        if let haveDisability = matchSeeker.getHeadlineText() {
                             Text(haveDisability).font(.subheadline)
                        }
                    }
                    
                    
                    Spacer()
                    
                    //a group of text relating to background check statues
                    Group {
                        if let haveBackgroundCheck = matchSeeker.backgroundCheck {
                            if haveBackgroundCheck.policeCheck != nil {
                                BackgroundCheckStatusView(text: "This match seeker has been policed checked", backgroundColor: backgroundCheckBackgroundColour, systemIconName: backgroundCheckIcon)
                            }
                            if haveBackgroundCheck.proofOfAge != nil {
                                BackgroundCheckStatusView(text: "This match seeker has been verified as a real person.", backgroundColor: backgroundCheckBackgroundColour, systemIconName: backgroundCheckIcon)
                            }
                            if haveBackgroundCheck.refereeCheck != nil {
                                BackgroundCheckStatusView(text: "This match seeker has been referee checked", backgroundColor: backgroundCheckBackgroundColour, systemIconName: backgroundCheckIcon)
                            }
                        }
                    }
                    
                    
                    //checks if it has been reported as a scammer.
                    if matchSeeker.isScammer {
                        BackgroundCheckStatusView(text: "This match seeker was known to be a scammer.", backgroundColor: scammerBackgroundColour, systemIconName: scamIcon)
                    }
                    //Text("Gender: \(matchSeeker.gender.rawValue.capitalized)")
                    Group {
                        Text("Bio").font(.headline).padding()
                        Text("\(matchSeeker.bio)").font(.body).padding()
                        Text("Hobbies").font(.headline).padding()
                        Text(matchSeeker.hobbies).padding()
                        Text("Favourite Music").padding()
                        Text("\(matchSeeker.favouriteMusic)")
                    }
                   
                }
                //this is where you would see the profile iamge
                
            }.padding().toolbar(.visible, for: .tabBar)
        }.toolbar {
            Button {
                showActionSheet = true
            } label: {
                Image(systemName: "ellipsis")
            }
        }.actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("What do you want to do with this MatchSeeker?"), buttons: [
                .default(Text(dreamListStatus)) {
                    handleDreamList()
                },
                .default(Text("Report Scam")) {
                    do {
                        //updates it on the backend side
                        try soulDatesMain.toggleMatchSeekerScammer(currentMatchSeeker: matchSeeker)
                        //imdediately updates it to the view side.
                        matchSeeker.toggleScammer()
                        session.gatherMatches(soulDatesMain: soulDatesMain)
                    }
                    catch {
                        showAlert = true
                        alertTitle = "An error has occurred."
                    }
                },
                .cancel()
            ])
        }.onAppear{
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
                    Text(alertTitle)
            )
        }
    }
    
    func handleDreamList() {
        do {
            if !session.checkAlreadyAdded(selectedMatchSeeker: matchSeeker) {
                session.addToDreamList(matchSeeker: matchSeeker)
                showAlert = true
                alertTitle = "Match Seeker added to Dream List."
            }
            else {
                try session.removeFromDreamList(matchSeeker: matchSeeker)
                showAlert = true
                alertTitle = "Match Seeker removed from Dream List."
            }
        }
        catch {
            showAlert = true
          alertTitle = "Unable to remove from Dream List."
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(matchSeeker: matchSeekersSample[1], selectedTab: .constant(.look) ).environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}
