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
    @Binding var isOnSession: Bool
    var body: some View {
        
       
            TabView(selection: $selectedTab) {
            
                LookView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Look", systemImage: "book.fill")
                }.tag(Tab.look)
                
                DreamListView(selectedTab: $selectedTab).tabItem {
                    Label("DreamList", systemImage: "heart.fill")
                }.tag(Tab.dreamList)
                
                SettingsView(selectedTab: $selectedTab, isOnSession: $isOnSession)
                .tabItem {
                    Label("Settings", systemImage: "sun.max")
                }.tag(Tab.settings)
            }
    }
}

struct InSessionTabView_Previews: PreviewProvider {
    static var previews: some View {
        InSessionTabView(isOnSession: .constant(true)).environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}
