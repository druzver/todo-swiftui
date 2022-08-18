//
//  SwiftUIView.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI
import domain
import Combine




class CalendarMonthViewModel: ObservableObject {

    let calendar = Calendar.current
    
    var startDate: Date
    var endDate: Date
    var dates: [Date] = []
    var title: String
    
    @Published var events: Dictionary<Int, Int> = [:] // day, count
    
    private var disposeBag = Set<AnyCancellable>()
    private var useCase: UseCaseFetchTasksCountForPeriod
  
    init(useCase: UseCaseFetchTasksCountForPeriod, startDate: Date, endDate: Date) {
        self.useCase = useCase
        self.startDate = startDate
        self.endDate = endDate
        title = DateFormatter.monthAndYear.string(from: startDate)
        dates = days(for: startDate)
        
    }
    
    func onAppear() {
        useCase.fetch(startDate: startDate, endDate: endDate)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] events in
                    self?.events = events
                }
            ).store(in: &disposeBag)
    }
    
    func getEventsCount(_ date: Date) -> Int {
        return events[date.day] ?? 0
    }
    
    func onDisapear() {
    }
    
    private func days(for month: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
    
    deinit {
        print("deinit CalendarMonthModel  \(title)")
    }
}




fileprivate extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }

        return dates
    }
}


fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}
