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
                let matchSeeker: Binding<MatchSeeker> = $session.matchSeeker
                Section("Basic Details") {
                    HStack{
                        Text("Screen Name: ")
                        TextField("", text: matchSeeker.screenName)
                    }
                    DatePicker("Date of birth:", selection: $session.matchSeeker.dateOfBirth, displayedComponents: [.date]).datePickerStyle(.compact)
                    Picker("Gender", selection: matchSeeker.gender) {
                        ForEach(Gender.allCases) { gender in
                            Text(gender.rawValue.capitalized)
                        }
                    }.pickerStyle(.navigationLink)
                }
                Section("Bio") {
                    TextEditor(text: matchSeeker.bio).frame(minHeight: 150)
                }
                Section("Hobbies") {
                    TextEditor(text: matchSeeker.hobbies).frame(minHeight: 150)
                }
                
              
                Section("Favourite Music")
                {
                    TextEditor(text: matchSeeker.favouriteMusic).frame(minHeight: 150)
                }
            }.onAppear {
                //updateProfileVM.screenName = 
            }
        }
    }
}

struct UpdateProFileView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateProfileView(updateProfileVM: UpdateProfileViewModel()).environmentObject(Session())
    }
}
