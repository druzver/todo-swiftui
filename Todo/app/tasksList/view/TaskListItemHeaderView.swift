//
//  TaskListItemHeaderView.swift
//  Todo
//
//  Created by Vitaly on 17.08.2022.
//

import SwiftUI


struct TaskListItemHeaderView: View {
    
    var text: String
    
    var body: some View {
        HStack() {
            Text(text.uppercased())
                .lineLimit(1)
                .font(.system(size: 18,weight: .bold))
                .foregroundColor(Color.gray)
            Spacer()
        }.frame(maxWidth: .infinity)
            .padding(10)
    }
}



#if DEBUG

struct TaskListItemHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListItemHeaderView(text: "Some header")
    }
}

#endif
