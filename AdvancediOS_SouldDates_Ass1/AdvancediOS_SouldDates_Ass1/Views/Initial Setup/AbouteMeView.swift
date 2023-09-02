//
//  AbouteMeView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 20/8/2023.
//

import SwiftUI

struct AbouteMeView: View {
    @ObservedObject var setupVM: InitialSetupViewModel
    var body: some View {
        NavigationStack {
            VStack {
                Text("Enter a bio about yourself.")
                TextEditor(text: $setupVM.bio).lineSpacing(4)
                Text("What are your favourite hobbies?")
                TextEditor(text: $setupVM.hobbies)
                Text("What is your favourite music?")
                TextEditor(text: $setupVM.favouriteMusic)
            }.navigationTitle("About Me")
        }
    }
}

struct AbouteMeView_Previews: PreviewProvider {
    static var previews: some View {
        AbouteMeView(setupVM: InitialSetupViewModel())
    }
}
