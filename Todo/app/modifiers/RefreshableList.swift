//
//  RefreshableList.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import SwiftUI


struct RefreshableList: ViewModifier {
    
    var action: () -> Void
    
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .refreshable(action: { action() })
        } else {
            content
        }
    }
}

