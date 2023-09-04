//
//  UpdateProFileView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import SwiftUI

struct UpdateProFileView: View {
    @EnvironmentObject var session: Session
    @ObservedObject var updateProfileVM: UpdateProfileViewModel
    var body: some View {
        List {
            HStack{
                Text("Screen Name: ")
                TextField("", text: $session.matchSeeker.screenName)
            }
        }
    }
}

struct UpdateProFileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProFileView(updateProfileVM: UpdateProfileViewModel())
    }
}
