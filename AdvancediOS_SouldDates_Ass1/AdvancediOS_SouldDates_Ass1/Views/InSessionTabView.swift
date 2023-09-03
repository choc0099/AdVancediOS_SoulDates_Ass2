//
//  InSessionTabView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import SwiftUI

struct InSessionTabView: View {
    var body: some View {
        TabView {
            LookView().tabItem {
                Label("Look", systemImage: "book.fill")
            }
            
            SettingsView().tabItem {
                Label("Settings", systemImage: "sun.max")
            }
        }
    }
}

struct InSessionTabView_Previews: PreviewProvider {
    static var previews: some View {
        InSessionTabView()
    }
}
