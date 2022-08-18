//
//  CalendarView.swift
//  Todo
//
//  Created by Vitaly on 17.08.2022.
//

import SwiftUI



struct CalendarView<DateView>: View where DateView: View {
    
    @Environment(\.calendar) var calendar
    
    let showHeaders: Bool
    let content: (Date) -> DateView
    var dates: [Date]
    var monthDate: Date
    var title: String
    
    private let cloumns:[GridItem] = Array(repeating: GridItem(), count: 7)
    
    init(
        dates: [Date],
        monthDate: Date,
        title: String,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {

        self.showHeaders = showHeaders
        self.content = content
        self.dates = dates
        self.title = title
        self.monthDate = monthDate
    }
    
    
    var body: some View {
        
        VStack {
            Text(title)
                .font(.title)
                .padding()
            
            LazyVGrid(columns:cloumns) {
                ForEach(dates, id: \.self) { date in
                    if calendar.isDate(date, equalTo: monthDate, toGranularity: .month) {
                        content(date).id(date)
                    } else {
                        content(date).hidden()
                    }
                }
            }
        }
        .frame(height: 350)
        
        
    }

}
