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
    var body: some View {
        ScrollView {
            VStack {
                //let matchSeeker = profileVM.matchSeeker
                Text("\(matchSeeker.screenName)").font(.title2).fontWeight(.bold)
                
                if let haveDisability = getDisabledText() {
                     Text(haveDisability).font(.subheadline)
                }
                Spacer()
                if matchSeeker.isScammer {
                    Text("This person was known to be a scammer.").padding()
                }
                
                Text("Bio").font(.headline).padding()
                Text("\(matchSeeker.bio)").font(.body).padding()
                Text("Hobbies").font(.headline).padding()
                Text(matchSeeker.hobbies).padding()
                Text("Favourite Music").padding()
                Text(matchSeeker.favouriteMusic).padding()
            }
        }.padding()
    }
    
    func getDisabledText() -> String?
    {
        var disabledText: String?
        if let haveDisability = matchSeeker.disability {
            if matchSeeker.datingPreference.discloseMyDisability {
                disabledText = "\(haveDisability.disabilities), \(haveDisability.severeity.rawValue.capitalized)"
            }
        }
        else {
            if matchSeeker.datingPreference.disabilityPreference == .openMinded
            {
                disabledText = "Positive about disabled."
            }
        }
        return disabledText
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(matchSeeker: matchSeekersSample[1])
    }
}
