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
                    ProfileImageView(matchSeekerImage: "logo", imageSize: 200)
                    Text("Welcome to SoulDates")
                        .font(.title)
                        .fontWeight(.bold).padding()
                    Text("Find your perfect match.").padding()
                    Spacer()
                    NavigationLink {
                        BasicDetailsSetupView(setupVM: InitialSetupViewModel(), isOnSession: $isOnSession)
                    } label: {
                        StyledButton(text: "GET STARTED", backGroundColour: .green, foregroundColour: .black)
                    }
                }
            }.padding()
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(isOnSession: .constant(true))
    }
}
