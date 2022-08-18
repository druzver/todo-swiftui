//
//  File.swift
//  
//
//  Created by Vitaly on 18.08.2022.
//

import Foundation
import UserNotifications


public class DefaultLocalNotificationRequestBuilder : LocalNotificationRequestBuilder {
    
    public enum TaskError : Error {
        case noRequiredData
        case noNeedToNotify
        case taskIsCompleted
    }
    
    public init() {}
    
    public func build(id: String, taskModel: TaskModel) throws -> UNNotificationRequest {
        let content = notificationContent(taskModel)
        
        
        if taskModel.completed {
            throw TaskError.taskIsCompleted
        }
        
        guard let date = taskModel.date, taskModel.remindBefore >= 1 else {
            throw TaskError.noRequiredData
        }
        
        let notificationTime = Date(timeInterval: TimeInterval(taskModel.remindBefore * -1) , since: date)
        
        if(notificationTime < Date()) {
            print("notify before now + 1 min ")
            throw TaskError.noNeedToNotify
        }
        
        
        let dateComponents = Calendar.current.dateComponents(
            [.day, .month, .year, .hour, .minute],
            from: notificationTime)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        return UNNotificationRequest(identifier: id, content: content, trigger: trigger)
    }
    
    private func notificationContent(_ taskModel: TaskModel) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        
        content.title = formatRemindDuration(taskModel.remindBefore)
        content.body = taskModel.title
        content.sound = .default
                
        return content
    }
    
    private func formatRemindDuration(_ duration: Int) -> String {
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.includesApproximationPhrase = true
        formatter.includesTimeRemainingPhrase = true
        formatter.allowedUnits = [.minute, .hour]
         
        let outputString = formatter.string(from: TimeInterval(duration))
        
        return outputString ?? ""
    }
    
    
    
}
