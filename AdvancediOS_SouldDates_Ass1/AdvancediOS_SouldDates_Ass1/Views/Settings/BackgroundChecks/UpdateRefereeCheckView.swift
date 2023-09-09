//
//  UpdateRefereeCheckView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdateRefereeCheckView: View {
    @ObservedObject var updateRefereeVM: UpdateRefereeCheckViewModel
    var body: some View {
        NavigationStack {
            Form {
                Toggle("Referee Check", isOn: $updateRefereeVM.isRefereeChecked)
                if updateRefereeVM.isRefereeChecked {
                    Section("Referee Details") {
                        HStack(spacing: 10) {
                            Text("Referee Name:").frame(width: 128, alignment: .leading)
                            TextField("Name", text: $updateRefereeVM.rafereeName)
                        }
                        DatePicker("Date issued", selection: $updateRefereeVM.dateIssued, displayedComponents: [.date])
                        DatePicker("Expiry Date", selection: $updateRefereeVM.expiryDate, displayedComponents: [.date])
                    }
                    Section("Description")
                    {
                        TextEditor(text: $updateRefereeVM.description)
                    }
                    
                }
            }
        }
    }
}

struct UpdateRefereeCheckView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateRefereeCheckView(updateRefereeVM: UpdateRefereeCheckViewModel())
    }
}
