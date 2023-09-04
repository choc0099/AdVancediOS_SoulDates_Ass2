//
//  SettingsView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        List() {
            Text("Update Profile")
            Text("Background checks")
            Text("Update Dating Preference")
            Text("Update Disability Details")
            Text("Reset")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
