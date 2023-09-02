//
//  InterestedInSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 2/9/2023.
//

import SwiftUI

struct InterestedInSetupView: View {
    @Binding var gender: Gender
    @Binding var dateOfBirth: Date
    @Binding var screenName: String
    @State var interestedInInput: InterestedIn = .all
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Who are you interested in?")
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
        InterestedInSetupView(gender: .constant(.male), dateOfBirth: .constant(Date.now), screenName: .constant("aaa"))
    }
}
