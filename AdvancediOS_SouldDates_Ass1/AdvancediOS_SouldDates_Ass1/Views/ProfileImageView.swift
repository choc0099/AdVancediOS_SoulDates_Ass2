//
//  ProfileImageView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 12/9/2023.
//

import SwiftUI

struct ProfileImageView: View {
    @State var matchSeekerImage: String?
    @State var imageSize: CGFloat
    var body: some View {
        if let hasImage = matchSeekerImage {
            Image(hasImage).resizable().8scaledToFill().frame(width: imageSize, height: imageSize).clipShape(Circle()).overlay{
                Circle().stroke(.gray, lineWidth: 5)
            }
        }
        else {
            Image(systemName: "person.fill").resizable().frame(width: imageSize, height: imageSize)
        }
        
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        let imageSize: Double = 250
        Group {
            ProfileImageView(matchSeekerImage: "women1", imageSize: imageSize)
            ProfileImageView(matchSeekerImage: "women2", imageSize: imageSize)
            ProfileImageView(matchSeekerImage: "men1", imageSize: imageSize)
            ProfileImageView(matchSeekerImage: "men2", imageSize: imageSize)
            ProfileImageView(imageSize: imageSize)
        }
        
    }
}
