//
//  EmptyTaskList.swift
//  Todo
//
//  Created by Vitaly on 17.08.2022.
//

import SwiftUI

struct EmptyTaskList: View {
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text("No Tasks")
                .font(.title2)
                .foregroundColor(Color.black)
            
            Text("Tap + button to add a new one")
                .font(.caption)
                .foregroundColor(Color.gray)
            
            Spacer()
        }
    }
}

struct EmptyTaskList_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTaskList()
    }
}
