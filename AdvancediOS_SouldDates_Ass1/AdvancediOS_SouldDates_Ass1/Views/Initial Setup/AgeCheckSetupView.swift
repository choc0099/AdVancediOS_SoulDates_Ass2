//
//  AgeCheckSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct AgeCheckSetupView: View {
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack() {
            Text("Enter your name:")
            TextField (
                "Name",
                text: $name
            )
            
            Text("What is your Age?")
            Stepper(<#T##title: StringProtocol##StringProtocol#>, value: <#T##Binding<Strideable>#>)
        }.padding()
       
        
    }
}

struct AgeCheckSetupView_Previews: PreviewProvider {
    static var previews: some View {
        AgeCheckSetupView()
    }
}
