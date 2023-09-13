//
//  backgroundCheckStatusView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 13/9/2023.
//

import SwiftUI

//this is a view for a background check
struct backgroundCheckStatusView: View {
    @State var text: String
    var body: some View {
       
        Text(text).padding().accentColor(Color("HighContrastForeground")).background(Color("GreenColour")).fontWeight(.bold).border(Color("HighContrastForeground"), width: 3)
        
    }
}

struct backgroundCheckStatusView_Previews: PreviewProvider {
    static var previews: some View {
        backgroundCheckStatusView(text: "This Match Seeker has been policed checked.")
    }
}
