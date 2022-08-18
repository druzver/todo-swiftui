//
//  ColorsPicker.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI

struct ColorsPicker: View {
    
    @Binding var selectedColor: Color
    
    var colors = [Color.red, Color.green, Color.yellow]
    
    var body: some View {
        HStack {
            ForEach(colors.indices, id:\.self) { index in
                
                let color = colors[index]
                let isSelected = color == selectedColor
                ColorView(color: color, isChecked: isSelected)
                    .frame(width: 40, height: 40)
                    .animation(.easeIn)
                    .onTapGesture {
                        selectedColor = color
                    }
                
            }
            
            
        }
        
        
    }
}


struct ColorsPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorsPicker(selectedColor: .constant(.red))
    }
}
