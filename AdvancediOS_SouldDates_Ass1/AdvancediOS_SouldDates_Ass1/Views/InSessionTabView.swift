//
//  InSessionTabView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import SwiftUI

enum Tab: Hashable {
    case look
    case dreamList
    case settings
}
struct InSessionTabView: View {
    @State var selectedTab: Tab = .look
    var body: some View {
        
            TabView(selection: $selectedTab) {
                //NavigationStack {
                    LookView(selectedTab: $selectedTab).navigationDestination(for: MatchSeeker.self) { matchSeekerProfile in
                        ProfileView(matchSeeker: matchSeekerProfile, selectedTab: .constant(.look))
                    }
                
                .tabItem {
                    Label("Look", systemImage: "book.fill")
                }.tag(Tab.look)
                //NavigationStack {
                    SettingsView()
                 
                .tabItem {
                    Label("Settings", systemImage: "sun.max")
                }.tag(Tab.settings)
            }
    }
}

struct InSessionTabView_Previews: PreviewProvider {
    static var previews: some View {
        InSessionTabView().environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}
