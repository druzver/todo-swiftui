//
//  Color+Extnsion.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import SwiftUI

extension Color {
    
    init(_ rgb: UInt) {
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
                
        self.init(red: r, green: g, blue: b, opacity: 1)
    }
    
    func toInt() -> UInt {
        
        let uic = UIColor(self)
        guard let components = uic.cgColor.components, components.count >= 3 else {
            return 0
        }
        
        let red = lround(components[0] * 255)
        let green = lround(components[1] * 255)
        let blue = lround(components[2] * 255 )
                
        return UInt (red << 16 | green << 8 | blue)
        
    }
    
}

extension UInt {
    func toColor() -> Color {
        return Color(self)
    }
}
