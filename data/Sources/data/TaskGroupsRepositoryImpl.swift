//
//  File.swift
//  
//
//  Created by Vitaly on 11.08.2022.
//

import Foundation
import domain
import CoreData
import Combine

extension GroupEntity {
    
    func toModel() -> TaskGroupModel  {
        return TaskGroupModel(
            id: self.id?.uuidString ?? "",
            title: self.name ?? ""
        )
    }
    
    func update(_ model: TaskGroupModel) {
        self.name = model.title
    }
    
}

extension TaskGroupModel {
    
    func toEntity(context: NSManagedObjectContext) -> GroupEntity {
        let entity = GroupEntity(context: context)
        entity.id = self.id != nil ? UUID(uuidString: self.id!) : UUID()
        entity.name = self.title
        return entity
    }
    
    
}


public class TaskGroupsRepositoryImpl : TaskGroupsRepository {
    
    private var db: TasksCoreDataProvider
    private var queue: DispatchQueue
    
    public init(db: TasksCoreDataProvider = DI.shared.dbProvider) {
        self.db = db
        self.queue = DispatchQueue.global()
    }
    
    public init(db: TasksCoreDataProvider = DI.shared.dbProvider, queue: DispatchQueue) {
        self.db = db
        self.queue = queue
    }

    public func getItems() -> AnyPublisher<[domain.TaskGroupModel], Error> {
        return Deferred { Future<[TaskGroupModel], Error> { [unowned self] result in
                do {
                    let ret = try db.groups().map { $0.toModel() }
                    result(.success(ret))
                } catch {
                    result(.failure(error))
                }
            }
        }
        .subscribe(on: queue)
        .eraseToAnyPublisher()
        

    }
    
    
    public func getItemBy(id: String) -> AnyPublisher<domain.TaskGroupModel, Error> {
        return Deferred { Future<TaskGroupModel, Error>() { [unowned self] result in
                do {
                    if let entity = try db.getGroupBy(id: id) {
                        result(.success(entity.toModel()))
                    } else {
                        result(.failure(RepositoryError.notFound) )
                    }
                    
                } catch {
                    result(.failure(error))
                }
            }
        }
        .subscribe(on: queue)
        .eraseToAnyPublisher()
        
    }
    
    public func save(_ model: domain.TaskGroupModel) -> AnyPublisher<domain.TaskGroupModel, Error> {
        return Deferred { Future<TaskGroupModel, Error>() { [unowned self] result in
                do {
                    if let id = model.id {
                        guard let entity = try db.getGroupBy(id: id) else {
                            result(.failure(RepositoryError.notFound) )
                            return
                        }
                        entity.update(model)
                        
                        let r = try db.saveGroup(entity).toModel()
                        result(.success(r))
                        
                    }
                    
                    let entity = model.toEntity(context: db.viewContext)
                    let r = try db.saveGroup(entity).toModel()
                    result(.success(r))
                    
                    
                } catch {
                    result(.failure(error))
                }
                
                
            }
        }
        .subscribe(on: queue)
        .eraseToAnyPublisher()
    }
    
    public func remove(_ model: domain.TaskGroupModel) -> AnyPublisher<Bool, Error> {
        return Deferred { Future<Bool, Error>() { [unowned self] result in
            guard let id = model.id else {
                result(.failure(RepositoryError.notFound) )
                return
            }
            
            do {
                try db.deleteGroupBy(id: id)
                result(.success(true) )
            } catch {
                result(.failure(error))
            }
            
        }}
        .subscribe(on: queue)
        .eraseToAnyPublisher()
    }
    
}
