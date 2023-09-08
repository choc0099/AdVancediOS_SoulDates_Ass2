//
//  UpdatePoliceCheckView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdatePoliceCheckView: View {
    @ObservedObject var updatePoliceCheckVM: UpdatePoliceCheckViewModel
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @EnvironmentObject var session: Session
    
    var body: some View {
        Form {
            Section("Police Check") {
                Toggle("Do you have police check?", isOn: $updatePoliceCheckVM.isPoliceChecked)
            }
            
            if updatePoliceCheckVM.isPoliceChecked {
                Section("Police Check Dates")
                {
                    DatePicker("Date issued:", selection: $updatePoliceCheckVM.issueDate, displayedComponents: [.date])
                    DatePicker("ExpiryDate", selection: $updatePoliceCheckVM.expiryDate, displayedComponents: [.date])
                }
                Section("Description") {
                    TextEditor(text: $updatePoliceCheckVM.description)
                }
                
                Section("Criminal Record")
                {
                    Toggle("Do you have criminal record?", isOn: $updatePoliceCheckVM.isCriminalRecord)
                }
            }
            
        }
    }
}

struct UpdatePoliceCheckView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePoliceCheckView(updatePoliceCheckVM: UpdatePoliceCheckViewModel())
    }
}
