//
//  WelcomeView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 19/8/2023.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcome: Bool
    var body: some View {
    
        NavigationStack {
            Text("Welcome to SoulDates")
                .font(.title)
                .fontWeight(.bold).padding()
            Text("Find your perfect match.").padding()
            NavigationLink {
                BasicDetailsSetupView(setupVM: InitialSetupViewModel(), showWelcome: $showWelcome)
            } label: {
                StyledButton(text: "GET STARTED", backGroundColour: .green, foregroundColour: .black)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(showWelcome: .constant(true))
    }
}
