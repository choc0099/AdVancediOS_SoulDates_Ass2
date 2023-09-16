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
    @State private var showAlert: Bool = false
    @State private var buttonDisabled: Bool = false
    
    
    @Binding var selectedTab: Tab
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Toggle("Do you have a disability?", isOn: $updateDisabilityVM.isDisabled).onChange(of: updateDisabilityVM.isDisabled) { isDisabled in
                //clears the fields on the VM when the disability toggle is set to false.
                if !isDisabled {
                    //clears input from the VM
                    disabilityText = ""
                    disabilitySeverity = .moderate
                    updateDisabilityVM.resetVM()
                }
            }
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
                
                Section(content: {
                    Toggle("Disclose my disability:", isOn: $updateDisabilityVM.discloseMyDisability)
                    Toggle("Risk getting rejected:", isOn: $updateDisabilityVM.riskGettingRejected)
                }, header: {
                    Text("Disability related settings")
                }, footer: {
                    Text("The risk of getting rejected toggle shows matchSeekers who do not declare that they are open minded.")
                }) 
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
        }.onChange(of: allTextEnetered(), perform: { textEnetered in
            if textEnetered {
                buttonDisabled = false
            } else {
                buttonDisabled = true
            }
        })
        .navigationTitle("Update Disability Details").toolbar{
            Button {
                do{
                    //handles changes
                    try processData()
                    //goes back to the previous view
                    presentationMode.wrappedValue.dismiss()
                }
                catch {
                    print("the matchSeeker from the session does not exist in the matchSeekerMain.")
                }
                
            } label: {
                Text("Done")
            }.disabled(buttonDisabled)
        }
    }
    
    func processData() throws {
        //updates it onto the main environment object
        try updateOnMain()
        // overwrites the disability details to userDefaults.
        try session.overWriteMatchSeekertoUserDefautls(soulDatesMain: soulDatesMain)
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
    }
    
    func allTextEnetered() -> Bool {
        if updateDisabilityVM.isDisabled {
            if !disabilityText.isEmpty {
                return true
            } else {
                return false
            }
        } else {
            //returns true if the user decided to no longer have their disability details
            //this is to ensure that the button is not disabled when the toggle is set to false
            return true
        }
    }
}

struct UpdateDisabilityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDisabilityDetailsView(updateDisabilityVM: UpdateDisabilityDetailsViewModel(), selectedTab: .constant(.settings)).environmentObject(Session()).environmentObject(SoulDatesMain())
    }
}
