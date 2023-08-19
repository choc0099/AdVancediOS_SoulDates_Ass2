//
//  WelcomeView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 19/8/2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            
            Text("Welcome to SoulDates")
                .font(.title)
                .fontWeight(.bold).padding()
            Text("Find your perfect match.").padding()
            Button("GET STARTED") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }.padding()
        }
        
        VStack {
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
