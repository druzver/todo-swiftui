//
//  Date+Extension.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import Foundation


extension Date {
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    public var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    public var startOfMonth: Date {
        let components = Calendar.current.dateComponents([.year, .month], from: startOfDay)
        return Calendar.current.date(from: components)!
    }

    public var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfMonth)!
    }
    
    
    public var nextDay: Date {
        var components = DateComponents()
        components.day = 1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    public var prevDay: Date {
        var components = DateComponents()
        components.day = -1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    public func addDays(days: Int) -> Date {
        var components = DateComponents()
        components.day = days
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    public func addMonthes(_ monthes: Int) -> Date {
        var components = DateComponents()
        components.month = monthes
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    
    public var day: Int {
        let c = Calendar.current.component(.day, from: self)
        return c
    }
}
