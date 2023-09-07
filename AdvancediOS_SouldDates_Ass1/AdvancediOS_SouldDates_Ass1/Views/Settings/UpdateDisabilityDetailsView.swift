//
//  UpdateDisabilityDetailsView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 5/9/2023.
//

import SwiftUI

struct UpdateDisabilityDetailsView: View {
    @ObservedObject var updateDisabilityVM: UpdateDisabilityDetailsViewModel
    @EnvironmentObject var soulDatesMain: SoulDatesMain
    @EnvironmentObject var session: Session
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
            
            if let matchSeekerHaveDisability = session.matchSeeker.disability {
                updateDisabilityVM.isDisabled = true
                disabilityText = matchSeekerHaveDisability.disabilities
                disabilitySeverity = matchSeekerHaveDisability.severeity
            }
            if let haveDisability = updateDisabilityVM.disability {
                disabilityText = haveDisability
            }
            if let haveDisabilitySeverity = updateDisabilityVM.disabilitySeverity {
                disabilitySeverity = haveDisabilitySeverity
            }
           
        }.navigationTitle("Update Disability Details").toolbar{
            Button {
                processData()
            } label: {
                Text("Done")
            }
        }
    }
    
    func processData() {
        updateOnSesstion()
        updateOnMain()
    }
    //this will update it on the model.
    func updateOnMain() {
        var disability: Disability?
        if updateDisabilityVM.isDisabled {
            disability = Disability(disabilities: disabilityText, severeity: disabilitySeverity)
        }
        else {
            disability = nil
        }
        
        soulDatesMain.updateMatchSeekerDisability(currentMatchSeeker: session.matchSeeker, disability: disability)
    }
    //this will update it on the session side.
    func updateOnSesstion() {
        //var disability: Disability?
        if updateDisabilityVM.isDisabled {
            //this will update disability details if they already have disabilities.
            if var haveDisability = self.session.matchSeeker.disability
            {
                haveDisability.updateDisabilityDetails(disabilities: disabilityText, disabilitySeverity: disabilitySeverity)
            }
            else {
                session.matchSeeker.disability = Disability(disabilities: disabilityText, severeity: disabilitySeverity)
            }
        }
        else {
            session.matchSeeker.disability = nil
        }
    }
}

struct UpdateDisabilityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDisabilityDetailsView(updateDisabilityVM: UpdateDisabilityDetailsViewModel())
    }
}
