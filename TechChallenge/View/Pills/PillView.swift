//
//  PillView.swift
//  TechChallenge
//
//  Created by Samuel Hervás on 11/11/2021.
//

import SwiftUI

struct Pill {
    let color: Color
    let text: String
}

struct PillView: View {
    let text: String
    let color: Color
    let action: ()-> Void
    
    var body: some View {
        Button(action: action) {
            Text(text).font(.title2).bold()
                .foregroundColor(.white).padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
        }
        .background(color).clipShape(RoundedRectangle(cornerRadius: 25))
        
    }
}


#if DEBUG
struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(text: "all", color: .black) {
            
        }
    }
}
#endif
