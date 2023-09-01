//
//  BasicDetailsSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct BasicDetailsSetupView: View {
    @Binding var dateOfBirth: Date
    @Binding var screenName: String
    @State var bio: String = ""
    @State var hobbies: String = ""
    
    var body: some View {
        Text("Coming up")
    }
}

struct BasicDetailsSetupView_Previews: PreviewProvider {
    static var previews: some View {
        BasicDetailsSetupView(dateOfBirth: .constant(Date.now), screenName: .constant("Cigarettes"))
    }
}
