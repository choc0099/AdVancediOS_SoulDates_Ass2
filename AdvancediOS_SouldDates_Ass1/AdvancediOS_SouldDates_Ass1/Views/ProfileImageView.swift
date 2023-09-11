//
//  ProfileImageView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 12/9/2023.
//

import SwiftUI

struct ProfileImageView: View {
    @State var matchSeekerImage: String?
    var body: some View {
        if let hasImage = matchSeekerImage {
            Image(hasImage).resizable().frame(width: 200, height: 200).clipShape(Circle())
        }
        else {
            Image(systemName: "person.fill").resizable().frame(width: 200, height: 200)
        }
        
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        //Group {
            ProfileImageView(matchSeekerImage: "women1")
            ProfileImageView(matchSeekerImage: "women2")
            ProfileImageView(matchSeekerImage: "men1")
            ProfileImageView(matchSeekerImage: "men2")
            ProfileImageView()
        //}
        
    }
}
