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
            VStack{
                Text("Who are you open of dating?").padding()
                ForEach(DisabilityPreference.allCases)
                {
                    pref in Button {
                        setupVM.disabilityPreference = pref
                        navActive = true
                    } label: {
                        Text(pref.rawValue).bold()
                    }.padding().frame(width: 240).background(.blue).foregroundColor(.black).border(.black).cornerRadius(5)
                }.navigationTitle("Dating Preferences")
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
