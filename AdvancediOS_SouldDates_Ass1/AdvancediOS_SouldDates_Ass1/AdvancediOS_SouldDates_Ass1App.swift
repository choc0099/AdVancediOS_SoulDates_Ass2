//
//  AdvancediOS_SouldDates_Ass1App.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 19/8/2023.
//

import SwiftUI

@main
struct AdvancediOS_SouldDates_Ass1App: App {
    
    var body: some Scene {
        
        WindowGroup {
            
            ContentView().environmentObject(Session()).environmentObject(SoulDatesMain())
        }
    }
}
