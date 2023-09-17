//
//  DreamListView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 11/9/2023.
//

import SwiftUI

struct DreamListView: View {
    @State var errorStatus: LookError = .noMatches
    @EnvironmentObject var session: Session
    @State var dreamList: [MatchSeeker] = []
    @Binding var selectedTab: Tab
    @State var showAlert: Bool = false
    var body: some View {
        NavigationStack {
            Group {
                if errorStatus == .noError {
                    List(dreamList) { matchSeeker in
                        //just like the Look view, it also navigates to the ProfileView.
                        NavigationLink (destination: ProfileView(matchSeeker: matchSeeker, selectedTab: $selectedTab))
                        {
                            MatchSeekerRow(matchSeeker: matchSeeker, selectedTab: $selectedTab).swipeActions {
                                //enables the user to delete an item from the dreamList by swiping left.
                                Button(role: .destructive) {
                                    selectedTab = .dreamList
                                    do {
                                        //deletes the item from the dreamList.
                                        try session.removeFromDreamList(matchSeeker: matchSeeker)
                                        loadDreamList() // refreshes the dreamList after remove.
                                    }
                                    catch {
                                        showAlert = true
                                    }
                                } label: {
                                    Label("Remove", systemImage: "trash.fill")
                                }
                            }
                        }
                    }
                }
                else {
                    //displays an error message that the dream list is empty as a method of error handling.
                    VStack(spacing: 20) {
                        Text("DreamList is Empty").font(.headline)
                        Text("You have not added any matches onto your DreamList.").multilineTextAlignment(.center)
                    }
                }
            }.navigationTitle("Dream List")
        }.onAppear {
            loadDreamList() //loads the dreamLists from session when inside this view.
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Unable to remove from Dream List!"))
        }
    }
    
    //this function retrieves data that is stored in the dreamList
    //and have error handling in an event such as an unexpected error or if there are no items in the dreamList.
    func loadDreamList() {
        do {
            dreamList = try session.getDreamList()
            errorStatus = .noError
        }
        catch {
            errorStatus = .noMatches
        }
    }
}

struct DreamListView_Previews: PreviewProvider {
    static var previews: some View {
        DreamListView(selectedTab: .constant(.dreamList)).environmentObject(Session())
    }
}
