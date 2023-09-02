//
//  InterestedInSetupView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 2/9/2023.
//

import SwiftUI

struct InterestedInSetupView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    @State private var navActive: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Who are you interested in?")
                Text("Test \(setupVM.screenName), \(setupVM.gender.rawValue)")
                ForEach(InterestedIn.allCases) {
                     interestedIn in
                    Button {
                        setupVM.interestedIn = interestedIn
                        navActive = true
                    } label: {
                        Text(interestedIn.rawValue.capitalized).bold()
                    }.padding().frame(width: 150).background(.blue).foregroundColor(.black).border(.black).cornerRadius(5)
                }
            }
        }.navigationDestination(isPresented: $navActive) {
            DisabilityStatusSetupView(setupVM: setupVM)
        }
        
    }
}

struct InterestedInSetupView_Previews: PreviewProvider {
    static var previews: some View {
        InterestedInSetupView(setupVM: InitialSetupViewModel())
    }
}
