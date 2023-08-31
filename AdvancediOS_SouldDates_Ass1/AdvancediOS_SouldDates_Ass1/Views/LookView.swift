//
//  LookView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct LookView: View {
    @State var matchSeekersAllocated: [MatchSeeker]
    var body: some View
    {
        NavigationStack {
            List(matchSeekersAllocated)
            {
                matchSeeker in
                MatchSeekerRow(matchSeeker: matchSeeker)
            }
        }
    }
}

struct LookView_Previews: PreviewProvider {
    static var previews: some View {
        LookView(matchSeekersAllocated:  matchSeekersSample)
    }
}
