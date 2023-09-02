//
//  BasicDetailsSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct GenderSetupView: View {
    @EnvironmentObject var basicDetailsVM: BasicDetailsViewModel
    //@State var interestedIn: InterestedIn = .all
    @ObservedObject var genderVM : GenderSetupViewModel
    @State var navActive = false
    
    
    var body: some View {
        //debug to see if date is passed
        
        NavigationStack {
            VStack {
                Text("What is your gender?").font(.headline)
                Text("Name test: \(basicDetailsVM.screenName)")
                
                ForEach(Gender.allCases) { gender in
                    Button {
                        genderVM.gender = gender
                        navActive = true
                         
                    } label: {
                        Text(gender.rawValue.capitalized).bold()
                    }.padding().frame(width: 150).background(.blue).foregroundColor(.black).border(.black).cornerRadius(5)
                }
            }
        }.navigationDestination(isPresented: $navActive) {
            InterestedInSetupView()
        }
    }
    
    func testDate(birthDate: Date)
    {
        print(birthDate)
    }
}

struct BasicDetailsSetupView_Previews: PreviewProvider {
    static var previews: some View {
        GenderSetupView(genderVM: GenderSetupViewModel())
      
    }
}
