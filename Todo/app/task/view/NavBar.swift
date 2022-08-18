//
//  NavBar.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI


struct NavBar: View {
    
    var title: String
    var createText: String = "Create"
    
    var isShowBackButton: Bool = true
    
    var onBack: () -> Void
    var onCreate: () -> Void
    
    
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.top)
                .shadow(radius: 10)
            HStack() {
            
                if(isShowBackButton) {
                    Button(action: onBack) {
                        Image(systemName: "xmark")
                    }
                }
                Spacer()
                Button(action: onCreate) {
                    Text(createText)
                }
            }.padding(.horizontal, 16)
            
            Text(title)
                .font(.title2)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 44)
        
        
    }
}


struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(title: "Hello", onBack: {}, onCreate: {})
    }
}
