//
//  ContentView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 19/8/2023.
//

import SwiftUI

struct ContentView: View {

    //@StateObject var soulDatesMain = SoulDatesMain()
    @State var selectedTab: Tab = .look
    var body: some View {
        
            TabView(selection: $selectedTab) {
                LookView(selectedTab: $selectedTab).tabItem {
                    Label("Look", systemImage: "book.fill")
                }.tag(Tab.look)
                
                SettingsView().tabItem {
                    Label("Settings", systemImage: "sun.max")
                }.tag(Tab.settings)
        

            }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
