//
//  VibrateOnTapModifier.swift
//  Todo
//
//  Created by Vitaly on 17.08.2022.
//

import SwiftUI
import UIKit
import AudioToolbox

struct VibrateTap: ViewModifier {
    
    var action: () -> Void
    
    private func vibrate() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                vibrate()
                action()
            }
    }
}

extension View {
    
    func onTapGestureVibrate( perform action: @escaping () -> Void) -> some View {
        return self.modifier(VibrateTap(action: action))
    }
    
}
