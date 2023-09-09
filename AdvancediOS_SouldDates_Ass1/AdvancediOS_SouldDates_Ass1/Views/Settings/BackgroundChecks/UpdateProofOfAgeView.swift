//
//  UpdateProofOfAgeView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 9/9/2023.
//

import SwiftUI

struct UpdateProofOfAgeView: View {
    @ObservedObject var updateProofOfAge: UpdateProofOfAgeViewModel
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Proof of Age Check", isOn: $updateProofOfAge.isProofOfAge)
                }
                
                if updateProofOfAge.isProofOfAge {
                    Section(content: {
                        HStack () {
                            Text("ID Number").frame(width: 100, alignment: .leading)
                            Spacer()
                            TextField("ID Number", text: $updateProofOfAge.proofOfAgeIdNumber)
                        }
                        HStack () {
                            Text("Issuer").frame(width: 100, alignment: .leading)
                            Spacer()
                            TextField("Issuer", text: $updateProofOfAge.issuer)
                        }
                        DatePicker("Date issued:", selection: $updateProofOfAge.dateIssued, displayedComponents: [.date])
                        DatePicker("Expiry Date", selection: $updateProofOfAge.expiryDate, displayedComponents: [.date])
                    }, header: {
                        Text("Proof of Age Details")
                    }, footer: {
                        Text("This is only a prototype, no API's are being used to verify proof of age.")
                    })
                    Section("Personal Details") {
                        HStack() {
                            Text("First Name").frame(width: 100, alignment: .leading)
                            TextField("First Name", text: $updateProofOfAge.legalFirstName)
                            
                        }
                        HStack {
                            Text("Last Name").frame(width: 100, alignment: .leading)
                            TextField("Last Name", text: $updateProofOfAge.legalLastName)
                        }
                        
                    }
                    Section("Address") {
                        TextEditor(text: $updateProofOfAge.address)
                    }
                }
            }
        }
    }
}

struct UpdateProofOfAgeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProofOfAgeView(updateProofOfAge: UpdateProofOfAgeViewModel())
    }
}
