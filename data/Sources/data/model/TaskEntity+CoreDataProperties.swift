//
//  TaskEntity+CoreDataProperties.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var color: Int32
    @NSManaged public var date: Date?
    @NSManaged public var remind: Int32
    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var groupId: String?
    @NSManaged public var completed: Bool
    @NSManaged public var group: GroupEntity?

}

extension TaskEntity : Identifiable {

}
