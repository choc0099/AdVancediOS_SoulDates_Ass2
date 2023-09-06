//
//  DatingPreferencesView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct DatingPreferencesView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    @State var navActive: Bool = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    Text("Who are you open of dating?").padding()
                    ForEach(DisabilityPreference.allCases)
                    {
                        pref in Button {
                            setupVM.disabilityPreference = pref
                            navActive = true
                        } label: {
                            StyledButton(text: pref.rawValue, backGroundColour: .blue, foregroundColour: .black)
                        }.padding()
                    }.navigationTitle("Dating Preferences")
                }
            }
        }.padding().navigationDestination(isPresented: $navActive) {
            AbouteMeView(setupVM: setupVM)
        }
    }
}

struct DatingPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        DatingPreferencesView(setupVM: InitialSetupViewModel())
    }
}
