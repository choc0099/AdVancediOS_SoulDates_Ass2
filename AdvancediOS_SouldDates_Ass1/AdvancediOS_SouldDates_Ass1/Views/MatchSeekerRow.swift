//
//  MatchSeekerRow.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import SwiftUI

struct MatchSeekerRow: View {
    @State var matchSeeker: MatchSeeker
    @Binding var selectedTab: Tab
    var body: some View {
     
        HStack(spacing: 20) {
            ProfileImageView(matchSeekerImage: matchSeeker.imageName, imageSize: 50)
            VStack(alignment: .leading) {
                Text(matchSeeker.screenName).font(.headline)
                Spacer()
                if let disabledMatchSeeker = matchSeeker.getHeadlineText() {
                    Text(disabledMatchSeeker)
                        .multilineTextAlignment(.leading)
                }
                else {
                    Text("")
                }
            }
        }.frame(height: 70)
        
    }
}

struct MatchSeekerRow_Previews: PreviewProvider {
    static var previews: some View {
        MatchSeekerRow(matchSeeker: matchSeekersSample[0], selectedTab: .constant(.look))
    }
}
