//
//  UpdateProFileView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 4/9/2023.
//

import SwiftUI

struct UpdateProfileView: View {
    @EnvironmentObject var session: Session
    @ObservedObject var updateProfileVM: UpdateProfileViewModel
    var body: some View {
        
        NavigationStack {
            Form {
                Section("Basic Details") {
                    HStack {
                        Text("Screen Name: ")
                        TextField("", text: $updateProfileVM.screenName)
                    }
                    DatePicker("Date of birth:", selection: $updateProfileVM.dateOfBirth, displayedComponents: [.date]).datePickerStyle(.compact)
                    Picker("Gender", selection: $updateProfileVM.gender) {
                        ForEach(Gender.allCases) { gender in
                           Text(gender.rawValue.capitalized)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Bio") {
                    TextEditor(text: $updateProfileVM.bio).frame(minHeight: 150)
                }
                Section("Hobbies") {
                    TextEditor(text: $updateProfileVM.hobbies).frame(minHeight: 150)
                }
                Section("Favourite Music")
                {
                    TextEditor(text: $updateProfileVM.favouriteMusic).frame(minHeight: 150)
                }
            }.onAppear {
            //transfers the properties from the session object to the updateProfileVM so it is isolated.
                let matchSeeker = session.matchSeeker
                updateProfileVM.screenName = matchSeeker.screenName
                updateProfileVM.dateOfBirth = matchSeeker.dateOfBirth
                updateProfileVM.favouriteMusic = matchSeeker.favouriteMusic
                updateProfileVM.gender = matchSeeker.gender
                updateProfileVM.hobbies = matchSeeker.hobbies
            }
        }.navigationTitle("Update Profile").toolbar {
            Button {
                
            } label: {
                Text("Done")
            }
        }
    }
}

struct UpdateProFileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView(updateProfileVM: UpdateProfileViewModel()).environmentObject(Session())
    }
}
