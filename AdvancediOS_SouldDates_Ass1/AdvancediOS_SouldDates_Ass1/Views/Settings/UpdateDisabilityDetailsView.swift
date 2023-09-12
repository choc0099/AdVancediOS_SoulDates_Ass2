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
    @State private var disabilityText: String = ""
    @State private var disabilitySeverity: DisabilitySeverity = .moderate
    @State private var navActive: Bool = false
    @State private var showAlert: Bool = false
    @Binding var isOnSession: Bool
    
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
                
                Section("Disability related settings:") {
                    Toggle("Disclose my disability:", isOn: $updateDisabilityVM.discloseMyDisability)
                    Toggle("Risk getting rejected:", isOn: $updateDisabilityVM.riskGettingRejected)
                }
            }
        }.onAppear {
            
            do {
                let allocatedMatchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
                if let matchSeekerHaveDisability = allocatedMatchSeeker.disability {
                    updateDisabilityVM.isDisabled = true
                    disabilityText = matchSeekerHaveDisability.disabilities
                    disabilitySeverity = matchSeekerHaveDisability.severeity
                    let datingPref = allocatedMatchSeeker.datingPreference
                    updateDisabilityVM.discloseMyDisability = datingPref.discloseMyDisability
                    updateDisabilityVM.riskGettingRejected = datingPref.riskGettingRejected
                }
                if let haveDisability = updateDisabilityVM.disability {
                    disabilityText = haveDisability
                }
                if let haveDisabilitySeverity = updateDisabilityVM.disabilitySeverity {
                    disabilitySeverity = haveDisabilitySeverity
                }
            }
            catch {
                print("The matchSeeker does not exist.")
            }
           
           
        }.navigationDestination(isPresented: $navActive, destination: {
            InSessionTabView(isOnSession: $isOnSession)
        }).navigationTitle("Update Disability Details").toolbar{
            Button {
                do{
                    try processData()
                    navActive = true
                }
                catch {
                    print("the matchSeeker from the session does not exist in the matchSeekerMain.")
                }
                
            } label: {
                Text("Done")
            }
        }
    }
    
    func processData() throws {
        
        try updateOnMain()
    }
    //this will update it on the model.
    func updateOnMain() throws {
        
        var disability: Disability?
        if updateDisabilityVM.isDisabled {
            disability = Disability(disabilities: disabilityText, severeity: disabilitySeverity)
        }
        else {
            disability = nil
        }
        
        let allocatedMatchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        try soulDatesMain.updateMatchSeekerDisability(currentMatchSeeker: allocatedMatchSeeker, disability: disability, discloseDisability: updateDisabilityVM.discloseMyDisability, riskRejections: updateDisabilityVM.riskGettingRejected)
        //saves it to user defaults, it will overwrite it.
        let updatedMatchSeeker = try soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
        SessionStorageManager.setMatchSeekerToUserDefaults(currentMatchSeeker: updatedMatchSeeker)
        
    }
    //this will update it on the session side.
}

struct UpdateDisabilityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDisabilityDetailsView(updateDisabilityVM: UpdateDisabilityDetailsViewModel(), isOnSession: .constant(true)).environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}
