//
//  RemindDuratioin.swift
//  Todo
//
//  Created by Vitaly on 17.08.2022.
//

import Foundation


enum RemindDuratioin: Int, CaseIterable {
    
    case minute = 60
    case minutes10 = 600
    case minutes30 = 1800
    case hour = 3600
    case day = 86400
    
    init?(rawValue: Int) {
        switch rawValue {
        case 60:
            self = .minute
        case 600:
            self = .minutes10
        case 1800:
            self = .minutes30
        case 3600:
            self = .hour
        case 86400:
            self = .day
        default:
            self = .hour
        }
    }
    
    func toString() -> String {
        switch self {
        case .minute:
            return "1 min"
        case .minutes10:
            return "10 min"
        case .minutes30:
            return "30 min"
        case .hour:
            return "1 hour"
        case .day:
            return "1 day"
        }
    }
    
    
}
