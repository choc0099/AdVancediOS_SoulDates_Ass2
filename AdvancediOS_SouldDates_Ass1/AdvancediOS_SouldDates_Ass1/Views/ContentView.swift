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
    @State var showWelcome: Bool = true
    var body: some View {
        
        //the welcome view will show up when the user runs the app
        //For the navigations in the tab view to work where tab bars are still visible,
        //I had to enbed the TabSessionView inside the ContentView and use pop overs for
        //the setup process.
        InSessionTabView().fullScreenCover(isPresented: $showWelcome) {
            WelcomeView(showWelcome: $showWelcome)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
