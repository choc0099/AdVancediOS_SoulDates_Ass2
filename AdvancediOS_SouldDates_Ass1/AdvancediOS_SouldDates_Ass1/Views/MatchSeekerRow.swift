//
//  MatchSeekerRow.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 30/8/2023.
//

import SwiftUI

struct MatchSeekerRow: View {
    @State var matchSeeker: MatchSeeker
    var body: some View {
     
        HStack {
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
            }.padding()
        }.frame(height: 70)
        
    }
}

struct MatchSeekerRow_Previews: PreviewProvider {
    static var previews: some View {
        MatchSeekerRow(matchSeeker: matchSeekersSample[3])
    }
}
