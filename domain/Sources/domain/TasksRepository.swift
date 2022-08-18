//
//  File.swift
//  
//
//  Created by Vitaly on 06.08.2022.
//

import Foundation
import Combine

public struct TaskModel : Identifiable {
    public var id: String?
    public var title: String
    public var date: Date?
    public var remindBefore: Int
    public var color: UInt
    public var groupId: String?
    public var completed: Bool = false
    
    
    
    public init(id: String? = nil, title: String, date: Date?, remindBefore: Int, color: UInt, groupId: String?, completed: Bool) {
        self.id = id
        self.title = title
        self.date = date
        self.remindBefore = remindBefore
        self.color = color
        self.groupId = groupId
        self.completed = completed
    }
    
    mutating public func toggleCompletion() {
        completed.toggle()
    }
}


public struct TasksRepositoryFilter {
    public var showComplited: Bool = false
    public var betweenDates: ClosedRange<Date>?
    public var groupId: String?
    
    public init(showComplited: Bool, betweenDates: ClosedRange<Date>? = nil, groupId: String? = nil) {
        self.showComplited = showComplited
        self.betweenDates = betweenDates
        self.groupId = groupId
    }
}


public protocol TasksRepository {
    
    func getItems(filter: TasksRepositoryFilter) -> AnyPublisher<[TaskModel], Error>
    
  
    
    func getItem(id: String) -> AnyPublisher<TaskModel, Error>
    
    func save(_ task: TaskModel) -> AnyPublisher<TaskModel, Error>
    
    func remove(_ task: TaskModel) -> AnyPublisher<Bool, Error>
    

}
