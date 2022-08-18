//
//  File.swift
//  
//
//  Created by Vitaly on 11.08.2022.
//

import Foundation
import Combine

public struct TaskGroupModel : Identifiable, Hashable {
    public var id: String?
    public var title: String
    
    public init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    public init(title: String) {
        self.id = nil
        self.title = title
    }
    
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


public protocol TaskGroupsRepository {
    
    func getItems() -> AnyPublisher<[TaskGroupModel], Error>
    
    func getItemBy(id: String) -> AnyPublisher<TaskGroupModel, Error>
    
    func save(_ model: TaskGroupModel) -> AnyPublisher<TaskGroupModel, Error>
    
    func remove(_ model: TaskGroupModel) -> AnyPublisher<Bool, Error>
    
}
