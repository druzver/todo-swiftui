//
//  File.swift
//  
//
//  Created by Vitaly on 18.08.2022.
//

import Foundation
import UserNotifications

public class UseCaseTaskNotification {
    
    private let notificationManager: NotificationManager
    private var requestBuilder: LocalNotificationRequestBuilder = DefaultLocalNotificationRequestBuilder()
    
    private var notificationCenter: UNUserNotificationCenter {
        get { notificationManager.notificationCenter }
    }
    
    public init(notificationManager: NotificationManager) {
        self.notificationManager = notificationManager
    }
    
    public init(notificationManager: NotificationManager, requestBuilder: LocalNotificationRequestBuilder) {
        self.notificationManager = notificationManager
        self.requestBuilder = requestBuilder
    }
    
    
    public func update(taskModel: TaskModel, completion: @escaping (Error?) -> Void ) {
        print("Update task notification", taskModel.title)
        //remove old and create new
        remove(taskModel: taskModel, completion: { error in
            if let error = error {
                completion(error)
            } else {
                self.create(taskModel: taskModel, completion: completion)
            }
        })
    }
    
    public func remove(taskModel: TaskModel, completion: @escaping (Error?) -> Void ) {
        print("Remove task notification", taskModel.title)
        let notificationId = createNotificationId(taskModel: taskModel)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationId])
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [notificationId])
        completion(nil)
    }
    
    
    public func create(taskModel: TaskModel, completion: @escaping (Error?) -> Void ) {
        print("Create task notification", taskModel.title)
        var request: UNNotificationRequest?
        let id = createNotificationId(taskModel: taskModel)
        do {
            request = try requestBuilder.build(id: id, taskModel: taskModel)
        } catch {
            completion(error)
            return
        }
        
        notificationCenter.add(request!) { error in
            completion(error)
        }
    }
    
    private func createNotificationId(taskModel: TaskModel) -> String {
        return taskModel.id ?? "0"
    }
}
