//
//  File.swift
//  
//
//  Created by Vitaly on 18.08.2022.
//

import Foundation
import UserNotifications


public class NotificationManager : NSObject, UNUserNotificationCenterDelegate {
    
    private var settings: UNNotificationSettings?
    
    public var notificationCenter: UNUserNotificationCenter
    
    public init(notificationCenter: UNUserNotificationCenter = UNUserNotificationCenter.current()) {
        self.notificationCenter = notificationCenter
        super.init()
        notificationCenter.delegate = self
    }
    
    public func requestAuthorization(completion: @escaping (Bool) -> Void ) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, err in
            completion(granted)
        }
    }
    
    public func fetchNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings() { settings in
            DispatchQueue.main.async {
                self.settings = settings
            }
        }
    }
    
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    
}
