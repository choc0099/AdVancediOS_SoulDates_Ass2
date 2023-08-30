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
                Text(matchSeeker.screenName)
                    .multilineTextAlignment(.leading)
                Spacer()
                if let disabledMatchSeeker = matchSeeker.disability {
                    Text(disabledMatchSeeker.disabilities)
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
