//
//  DreamListView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 11/9/2023.
//

import SwiftUI

struct DreamListView: View {
    @State var errorStatus: LookError = .noMatches
    @EnvironmentObject var session: Session
    @State var dreamList: [MatchSeeker] = []
    @Binding var selectedTab: Tab
    var body: some View {
        NavigationStack {
            Group {
                if errorStatus == .noError {
                    List(dreamList) { matchSeeker in
                        NavigationLink(destination: ProfileView(matchSeeker: matchSeeker, selectedTab: $selectedTab)) {
                            MatchSeekerRow(matchSeeker: matchSeeker, selectedTab: $selectedTab)
                        }
                    }
                }
                else {
                    VStack(spacing: 20) {
                        Text("DreamList is Empty").font(.headline)
                        Text("You have not added any matches onto your DreamList.")
                    }
                    
                }
            }
        }.onAppear {
            do {
                dreamList = try session.getDreamList()
                errorStatus = .noError
            }
            catch {
                errorStatus = .noMatches
            }
        }
    }
}

struct DreamListView_Previews: PreviewProvider {
    static var previews: some View {
        DreamListView(selectedTab: .constant(.dreamList)).environmentObject(Session())
    }
}
