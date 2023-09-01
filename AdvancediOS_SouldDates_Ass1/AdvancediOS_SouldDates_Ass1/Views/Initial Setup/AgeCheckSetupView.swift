//
//  AgeCheckSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct AgeCheckSetupView: View {
    @State private var name: String = ""
    @State private var dateOfBirth: Date = Date.now
    
    var body: some View {
        NavigationStack() {
            Text("Enter your name:")
            TextField (
                "Name",
                text: $name
            )
            DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: [.date]).datePickerStyle(.wheel)
        }.padding()
        
    }
}

struct AgeCheckSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AgeCheckSetupView()
    }
}
