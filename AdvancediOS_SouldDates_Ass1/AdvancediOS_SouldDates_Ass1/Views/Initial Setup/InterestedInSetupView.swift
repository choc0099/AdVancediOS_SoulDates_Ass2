//
//  InterestedInSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 2/9/2023.
//

import SwiftUI

struct InterestedInSetupView: View {
    @EnvironmentObject var basicVM: InitialSetupViewModel
    @EnvironmentObject var genderVM: GenderSetupViewModel
    @State var interestedInInput: InterestedIn = .all
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Who are you interested in?")
                Text("Test \(basicVM.screenName), \(genderVM.gender.rawValue)")
                ForEach(InterestedIn.allCases) {
                     interestedIn in
                    Button {
                        interestedInInput = interestedIn
                    } label: {
                        Text(interestedIn.rawValue.capitalized).bold()
                    }.padding().frame(width: 150).background(.blue).foregroundColor(.black).border(.black).cornerRadius(5)
                }
            }
        }
        
    }
}

struct InterestedInSetupView_Previews: PreviewProvider {
    static var previews: some View {
        InterestedInSetupView()
    }
}
