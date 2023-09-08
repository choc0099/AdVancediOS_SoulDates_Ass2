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
    @State var navActive: Bool = false
    @State var showAlert: Bool = false
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
            
            let allocatedMatchSeeker = try! soulDatesMain.getSpecificMatchSeeker(matchSeekerId: session.matchSeekerId)
            if let matchSeekerHaveDisability = allocatedMatchSeeker.disability {
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
           
        }.navigationDestination(isPresented: $navActive, destination: {
            InSessionTabView()
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
        try soulDatesMain.updateMatchSeekerDisability(currentMatchSeeker: allocatedMatchSeeker, disability: disability)
    }
    //this will update it on the session side.
}

struct UpdateDisabilityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDisabilityDetailsView(updateDisabilityVM: UpdateDisabilityDetailsViewModel())
    }
}
