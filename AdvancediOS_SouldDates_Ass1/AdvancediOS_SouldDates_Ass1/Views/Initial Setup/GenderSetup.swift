//
//  BasicDetailsSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct GenderSetupView: View {
    @Binding var dateOfBirth: Date
    @Binding var screenName: String
    //@State var interestedIn: InterestedIn = .all
    @State var genderInput: Gender = .male
    @State var navActive = false
    
    
    var body: some View {
        //debug to see if date is passed
        
        NavigationStack {
            VStack {
                Text("What is your gender?").font(.headline)
                
                ForEach(Gender.allCases) { gender in
                    Button {
                        genderInput = gender
                        navActive = true
                         
                    } label: {
                        Text(gender.rawValue.capitalized).bold()
                    }.padding().frame(width: 150).background(.blue).foregroundColor(.black).border(.black).cornerRadius(5)
                }
            }
        }.navigationDestination(isPresented: $navActive) {
            InterestedInSetupView(gender: $genderInput, dateOfBirth: $dateOfBirth, screenName: $screenName)
        }
    }
    
    func testDate(birthDate: Date)
    {
        print(birthDate)
    }
}

struct BasicDetailsSetupView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSetupView(dateOfBirth: .constant(Date.now), screenName: .constant("Cigarettes"))
      
    }
}
