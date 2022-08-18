//
//  MonthView.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI


struct MonthView: View {
    
    @StateObject var model: CalendarMonthViewModel

    var onDaySelect: (Date) -> Void
    
    @Environment(\.calendar) var calendar
    
    @ViewBuilder func dayView(_ date: Date) -> some View {
        let eventCounts = model.getEventsCount(date)
        let isToday = calendar.isDateInToday(date)
        
        DayView(day: "\(date.day)", eventsCount: eventCounts, isToday: isToday)
            .onTapGesture {
                onDaySelect(date)
            }
    }
    
    var body: some View {
        CalendarView(
            dates: model.dates,
            monthDate: model.startDate,
            title: model.title,
            content: self.dayView
        ).onAppear() {
            model.onAppear()
        }.onDisappear() {
            model.onDisapear()
        }
    }
}


