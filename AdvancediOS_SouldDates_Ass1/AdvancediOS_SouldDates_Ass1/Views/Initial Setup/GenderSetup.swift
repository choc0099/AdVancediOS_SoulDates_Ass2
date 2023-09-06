//
//  BasicDetailsSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct GenderSetupView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    //@State var interestedIn: InterestedIn = .all
    @State var navActive = false
    
    
    var body: some View {
        //debug to see if date is passed
        
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("What is your gender?").font(.headline)
                    
                    ForEach(Gender.allCases) { gender in
                        Button {
                            navActive = true
                            setupVM.gender = gender
                             
                        } label: {
                            StyledButton(text: gender.rawValue.capitalized, backGroundColour: Color("GreenColour"), foregroundColour: Color("HighContrastForeground"))
                        }.padding()
                    }
                }.navigationTitle("Gender Details")
            }
        }.navigationDestination(isPresented: $navActive) {
            InterestedInSetupView(setupVM: setupVM)
        }
    }
    
    func testDate(birthDate: Date)
    {
        print(birthDate)
    }
}

struct BasicDetailsSetupView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSetupView(setupVM: InitialSetupViewModel())
      
    }
}
