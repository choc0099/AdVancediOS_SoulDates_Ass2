//
//  UpdateDisabilityDetailsView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 5/9/2023.
//

import SwiftUI

struct UpdateDisabilityDetailsView: View {
    @ObservedObject var updateDisabilityVM: UpdateDisabilityDetailsViewModel
    @State var disabilityText: String = ""
    @State var disabilitySeverity: DisabilitySeverity = .moderate
    var body: some View {
        Form {
            Toggle("Do you have a disability?", isOn: $updateDisabilityVM.isDisabled )
            if updateDisabilityVM.isDisabled {
                Section("Disability Details") {
                    
                    TextField("What Disability do you have?", text: $disabilityText)
                }
                
                Picker("How severe is your disability", selection: $disabilitySeverity) {
                    ForEach(DisabilitySeverity.allCases)
                    {
                        severity in Text(severity.rawValue.capitalized)
                    }
                }.pickerStyle(.segmented)
                
                Section {
                    Toggle("Disclose my disability: ", isOn: $updateDisabilityVM.discloseMyDisability)
                }
            }
        }.onAppear {
            if let haveDisability = updateDisabilityVM.disability {
                disabilityText = haveDisability
            }
        }
    }
}

struct UpdateDisabilityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDisabilityDetailsView(updateDisabilityVM: UpdateDisabilityDetailsViewModel())
    }
}
