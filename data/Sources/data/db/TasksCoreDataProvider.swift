//
//  File.swift
//  
//
//  Created by Vitaly on 17.08.2022.
//

import Foundation
import CoreData
import domain


public protocol TasksCoreDataProvider {
    
    
    var viewContext: NSManagedObjectContext {get}
    
    func tasks(filter: domain.TasksRepositoryFilter) throws -> [TaskEntity]
    func tasks() throws -> [TaskEntity]
    func tasks(groupId: String) throws -> [TaskEntity]
    
    func getTaskBy(id: String) throws -> TaskEntity?
    func saveTask(_ entity: TaskEntity) throws -> TaskEntity
    func deleteTaskBy(id: String) throws
    
    
    func groups() throws -> [GroupEntity]
    func getGroupBy(id: String) throws -> GroupEntity?
    func saveGroup(_ entity: GroupEntity) throws -> GroupEntity
    func deleteGroupBy(id: String) throws
    
    
}


public class TasksCoreDataProviderImpl : TasksCoreDataProvider {
   
    private (set) var coreDataManager: NSPersistentContainer
    
    private var bgContext: NSManagedObjectContext
    
    public var viewContext: NSManagedObjectContext {
        get { bgContext }
    }
    
    public init(coreDataManager: NSPersistentContainer) {
        bgContext = coreDataManager.newBackgroundContext()
        self.coreDataManager = coreDataManager
    }
    
    public func tasks(filter: domain.TasksRepositoryFilter) throws -> [TaskEntity] {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.sortDescriptors = [.init(key: "date", ascending: true)]
        var predicates:[NSPredicate] = []
        
        if let groupId = filter.groupId {
            predicates.append(NSPredicate(format: "groupId =  %@", groupId))
        }
        
        if ( !filter.showComplited ) {
            predicates.append(NSPredicate(format:"completed == %@", NSNumber(false) ))
        }
        
        if let dates = filter.betweenDates {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            predicates.append(NSPredicate(
                format: "date >= %@ AND date <= %@",
                dates.lowerBound as NSDate,
                dates.upperBound as NSDate
            ))
        }
        
        fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        return try self.viewContext.fetch(fetchRequest)
    }
    
    public func tasks() throws -> [TaskEntity] {
        let fetchRequest = TaskEntity.fetchRequest()
        return try self.viewContext.fetch(fetchRequest)
    }
    
    public func tasks(groupId: String) throws -> [TaskEntity] {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "groupId =  %@", groupId)
        return try self.viewContext.fetch(fetchRequest)
    }
    
    public func getTaskBy(id: String) throws -> TaskEntity? {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id =  %@", id)
        return try self.viewContext.fetch(fetchRequest).first
    }
    
    public func saveTask(_ entity: TaskEntity) throws -> TaskEntity {
        if entity.id == nil {
            entity.id = UUID()
            self.viewContext.insert(entity)
        }
        
        try self.viewContext.save()
        return entity
    }
    
    public func deleteTaskBy(id: String) throws {
        guard let item = try getTaskBy(id: id) else { return }
        viewContext.delete(item)
        try viewContext.save()
        
    }
    
    
    
    
    public func groups() throws -> [GroupEntity] {
        let r = GroupEntity.fetchRequest()
        return try viewContext.fetch(r)
    }
    
    public func getGroupBy(id: String) throws -> GroupEntity? {
        let fetchRequest = GroupEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id =  %@", id)
        fetchRequest.fetchLimit = 1
        return try self.viewContext.fetch(fetchRequest).first
        
    }
    
    public func saveGroup(_ entity: GroupEntity) throws -> GroupEntity {
        if entity.id == nil {
            entity.id = UUID()
            self.viewContext.insert(entity)
        }
        
        try self.viewContext.save()
        return entity
    }
    
    public func deleteGroupBy(id: String) throws {
        guard let item = try getGroupBy(id: id) else { return }
        viewContext.delete(item)
        try viewContext.save()
    }
    
    
    
    
}
