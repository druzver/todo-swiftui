//
//  DayView.swift
//  Todo
//
//  Created by Vitaly on 17.08.2022.
//

import SwiftUI


struct DayView: View {
    
    var day: String
    var eventsCount: Int
    var isToday: Bool
    
    var body: some View {
        Text(day)
            .padding(8)
            .background( isToday ? Color.blue.opacity(0.2) : Color.clear)
            .background(buildBadgeView() )
    }
    
    @ViewBuilder func buildBadgeView() -> some View {
        if (eventsCount == 0) {
            EmptyView()
        } else {
            VStack() {
                
                HStack() {
                    Spacer()
                    Circle().fill(Color.blue).frame(width: 5, height: 5)
                }
                Spacer()
            }.padding(5)
        }
    }
}

#if DEBUG

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(day: "21", eventsCount: 1, isToday: false)
    }
}

#endif
