//
//  backgroundCheckStatusView.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 13/9/2023.
//

import SwiftUI

//this is a view for a background check
struct BackgroundCheckStatusView: View {
    @State var text: String
    @State var backgroundColor: Color
    @State var foregroundColor: Color
    @State var systemIconName: String
    var body: some View {
       
        HStack(spacing: 5) {
            Image(systemName: systemIconName)
            Text(text).fontWeight(.bold)
        }.padding().accentColor(foregroundColor).background(backgroundColor).border(Color("HighContrastForeground"), width: 3)
        
    }
}

struct backgroundCheckStatusView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCheckStatusView(text: "This Match Seeker has been policed checked.", backgroundColor: Color("GreenColour"), foregroundColor: Color("HighContrastForegroundColour"), systemIconName: "checkmark.seal")
    }
}
