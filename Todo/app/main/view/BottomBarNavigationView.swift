//
//  BottomBarNavigationView.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI

struct BottomBarNavigationView: View {
    
    @Binding var selectedItem: Int
    
    var onAdd: () -> Void
    
    var body: some View {
        ZStack {
            BottomBarShape()
                .fill(Color(0xF8F8F8))
                .edgesIgnoringSafeArea(.bottom)
                .shadow(color:.black.opacity(0.1), radius: 5, y: -5)
            
            HStack() {
                Spacer()
                BottomBarNavigationViewItem(
                    title: "Tasks",
                    image: "list.dash",
                    index: 0,
                    selectedItem: $selectedItem
                    
                )
                    .onTapGesture {
                        selectedItem = 0
                    }
                Spacer()
                AddTaskButton()
                    .offset(y: -25)
                    .onTapGesture {
                        onAdd()
                    }
                Spacer()
//                BottomBarNavigationViewItem(title: "Home", image: "house")
//                Spacer()
                BottomBarNavigationViewItem(
                    title: "Calendar",
                    image: "calendar",
                    index: 1,
                    selectedItem: $selectedItem
                )
                   
                Spacer()
                
                
            }
            
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        
    }
}



struct BottomBarNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarNavigationView(selectedItem: .constant(1), onAdd: {})
    }
}

struct BottomBarNavigationViewItem: View {
    var title: String
    var image: String
    var index: Int
    
    @Binding var selectedItem: Int
    
    var isSelected: Bool {
        selectedItem == index
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: image)
                .foregroundColor(isSelected ?  Color.black : Color.gray )
            Text(title)
                .font(.system(size: 10))
                .foregroundColor(isSelected ?  Color.black : Color.gray )
            
        }.onTapGesture {
            selectedItem = index
        }
    }
}

struct AddTaskButton: View {
    var body: some View {
        
        Image(systemName: "plus")
            .resizable()
            .frame(width: 16, height: 16)
            .padding(16)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Circle())
            .padding(4)
            .background(Color.white)
            .clipShape(Circle())
            
            
    }
}


struct BottomBarShape: Shape {
    
    var radius: CGFloat = 10
    
    var corners: UIRectCorner = [.topLeft, .topRight]
    
    func path(in rect: CGRect) -> Path {
        let b = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        
        
        
        return Path(b.cgPath)
        
    }
}
