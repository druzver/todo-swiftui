//
//  File.swift
//  
//
//  Created by Vitaly on 18.08.2022.
//

import Foundation
import UserNotifications

public protocol LocalNotificationRequestBuilder {
    
    func build(id: String, taskModel: TaskModel) throws -> UNNotificationRequest
}

