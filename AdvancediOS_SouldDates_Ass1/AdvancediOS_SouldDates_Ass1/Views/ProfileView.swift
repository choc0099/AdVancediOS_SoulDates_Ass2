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
        
            //let matchSeeker = profileVM.matchSeeker
            Group {
                Text("\(matchSeeker.screenName)").font(.title2).fontWeight(.bold)
                
                if let haveDisability = matchSeeker.getHeadlineText() {
                     Text(haveDisability).font(.subheadline)
                }
            }
           
            Spacer()
            if matchSeeker.isScammer {
                Text("This person was known to be a scammer.").padding()
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
           
        }.padding()
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(matchSeeker: matchSeekersSample[1])
    }
}
