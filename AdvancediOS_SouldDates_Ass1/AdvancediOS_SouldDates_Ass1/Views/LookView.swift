//
//  LookView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct LookView: View {
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    var body: some View
    {
        NavigationStack {
            List(soulDatesMain.matchSeekers)
            {
                matchSeeker in
                MatchSeekerRow(matchSeeker: matchSeeker)
            }
        }
    }
}

struct LookView_Previews: PreviewProvider {
    static var previews: some View {
        LookView().environmentObject(SoulDatesMain())
    }
}
