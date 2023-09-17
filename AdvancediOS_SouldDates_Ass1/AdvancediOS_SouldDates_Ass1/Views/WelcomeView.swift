//
//  WelcomeView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 19/8/2023.
//

import SwiftUI

struct WelcomeView: View {
    @Binding var isOnSession: Bool
    var body: some View {
    
        NavigationStack {
            ScrollView {
                VStack(spacing: 10) {
                    //dispplays the SoulDates logo I have customly made using my iPad.
                    ProfileImageView(matchSeekerImage: "logo", imageSize: 200)
                    Text("Welcome to SoulDates")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                    Text("Become a Match Seeker today, find your perfect match.").multilineTextAlignment(.center).padding()
                    Spacer(minLength: 70)
                    //this is a button that navigates to the inital setup process.
                    NavigationLink {
                        BasicDetailsSetupView(setupVM: InitialSetupViewModel(), isOnSession: $isOnSession)
                    } label: {
                        StyledButton(text: "GET STARTED", backGroundColour: .green, foregroundColour: .black)
                    }
                }.frame(maxWidth: .infinity)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(isOnSession: .constant(true))
    }
}
