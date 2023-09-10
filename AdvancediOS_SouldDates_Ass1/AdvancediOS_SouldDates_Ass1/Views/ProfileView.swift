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
    @Binding var selectedTab: Tab
    @State var showActionSheet: Bool = false
    var body: some View {
        
        NavigationStack {
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
               
            }.padding().toolbar(.visible, for: .tabBar)
        }.toolbar {
            Button {
                showActionSheet = true
            } label: {
                Image(systemName: "ellipsis")
            }
        }.actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text("What do you want to do with this MatchSeeker?"), buttons: [
                .default(Text("Add to DreamList")),
                .default(Text("Report Scam")),
                .cancel()
            ])
        }
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(matchSeeker: matchSeekersSample[1], selectedTab: .constant(.look) )
    }
}
