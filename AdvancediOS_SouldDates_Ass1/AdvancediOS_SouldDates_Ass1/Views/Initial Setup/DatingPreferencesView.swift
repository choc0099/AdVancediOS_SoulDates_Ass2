//
//  DatingPreferencesView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct DatingPreferencesView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    var body: some View {
        NavigationStack {
            VStack{
                Text("Who are you open of dating?")
                ForEach(DisabilityPreference.allCases)
                {
                    pref in Button {
                        
                    } label: {
                        Text(pref.rawValue)
                    }
                }
            }
            
        }
    }
}

struct DatingPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        DatingPreferencesView(setupVM: InitialSetupViewModel())
    }
}
