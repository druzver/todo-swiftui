//
//  DIContainer.swift
//  Todo
//
//  Created by Vitaly on 09.08.2022.
//

import Foundation
import CoreData
import domain
import data

protocol DIContainer {
    var tasksRepository: TasksRepository {get}
    var groupsRepository: TaskGroupsRepository {get}
    var notificationManager: NotificationManager {get}
}

class DIContainerImpl: DIContainer {
    
    

    lazy var repositoryQueue: DispatchQueue = {
        DispatchQueue(label: "RepositoryQueue", attributes: .concurrent)
    }()
    
    lazy var tasksRepository: TasksRepository = {
        return TasksRepositoryImpl(queue: repositoryQueue)
    }()
    
    lazy var groupsRepository: TaskGroupsRepository = {
        return TaskGroupsRepositoryImpl(queue: repositoryQueue)
    }()
    
    
    lazy var notificationManager: NotificationManager = {
        return NotificationManager(notificationCenter: .current())
    }()
    
}
