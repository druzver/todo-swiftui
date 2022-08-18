//
//  HideKeyboardOnDrag.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI



struct HideKeyboardOnDrag: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.windows.forEach { $0.endEditing(false) }
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
