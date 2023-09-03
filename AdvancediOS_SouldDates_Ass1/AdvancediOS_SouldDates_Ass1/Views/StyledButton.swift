//
//  StyledButton.swift
//  AdvancediOS_SouldDates_Ass1
//
//  Created by Christopher Averkos on 3/9/2023.
//

import SwiftUI

struct StyledButton: View {
    let text: String
    let backGroundColour: Color
    let foregroundColour: Color
    
    
    var body: some View {
        Text(text).fontWeight(.bold).foregroundColor(foregroundColour).padding().frame(width: 250).background(backGroundColour)
            .overlay(
                RoundedRectangle(cornerRadius: 5).stroke(.black, lineWidth: 2)
            )
            
            
    }
}

struct StyledButton_Previews: PreviewProvider {
    static var previews: some View {
        StyledButton(text: "Cigarettes", backGroundColour: .green, foregroundColour: .black)
    }
}
