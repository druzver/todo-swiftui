//
//  ColorView.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI

struct ColorView: View {
    
    var color: Color
    
    var isChecked: Bool
    
    var checkedImage = "checkmark.circle.fill"
    var uncheckedImage = "circle.fill"
    
    var body: some View {
        Image(systemName: isChecked ? checkedImage : uncheckedImage)
            .resizable()
            .scaledToFit()
            .foregroundColor(color)
    }
}


struct ColorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorView(color: .red, isChecked: true)
    }
}

