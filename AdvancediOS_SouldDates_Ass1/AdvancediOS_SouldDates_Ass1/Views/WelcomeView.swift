//
//  WelcomeView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 19/8/2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        
        NavigationStack {
            VStack {
                
                Text("Welcome to SoulDates")
                    .font(.title)
                    .fontWeight(.bold).padding()
                Text("Find your perfect match.").padding()
                NavigationLink("GET STARTED") {
                    BasicDetailsSetupView()
                }
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
