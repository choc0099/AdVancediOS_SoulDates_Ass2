//
//  InSessionTabView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import SwiftUI

struct InSessionTabView: View {
    enum Tab {
        case look
        case dreamList
        case settings
    }
    var body: some View {
     
        NavigationStack {
            TabView {
                LookView().tabItem {
                    Label("Look", systemImage: "book.fill")
                }.tag(Tab.look)
                
                SettingsView().tabItem {
                    Label("Settings", systemImage: "sun.max")
                }.tag(Tab.settings)
            }.navigationTitle("Look").navigationBarBackButtonHidden(true).navigationBarTitleDisplayMode(.large)
        }
    }
}

struct InSessionTabView_Previews: PreviewProvider {
    static var previews: some View {
        InSessionTabView().environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}
