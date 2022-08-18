import domain
import CoreData
import Foundation
import Combine

extension TaskModel {
    
    init(entity: TaskEntity) {
        
        self.init(
            id: entity.id?.uuidString,
            title: entity.title ?? "",
            date: entity.date ?? Date(),
            remindBefore: Int(entity.remind),
            color: UInt(Int(entity.color)),
            groupId: entity.groupId,
            completed: entity.completed)
        
        
        
        
    }
    
    func toEntity(context: NSManagedObjectContext) -> TaskEntity {
        let ret = TaskEntity(context: context)
        ret.update(model: self)
        return ret
    }
    
}


extension TaskEntity {
    
    func toModel() -> TaskModel {
        return TaskModel(entity: self)
    }
    
    func update(model: TaskModel)  {
        
        self.id =  (model.id != nil) ? UUID(uuidString: model.id!) : nil
        self.remind = Int32(model.remindBefore)
        self.title = model.title
        self.color = Int32(model.color)
        self.date = model.date
        self.groupId = model.groupId
        self.completed = model.completed
    }
}



public class TasksRepositoryImpl : TasksRepository {
   
    
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
    
    public func getItems(filter: domain.TasksRepositoryFilter) -> AnyPublisher<[domain.TaskModel], Error> {
        return Deferred { Future<[TaskModel], Error> { [unowned self] result in
            do {
                let tasks = try db.tasks(filter: filter).map() { $0.toModel() }
                result(.success(tasks))
            } catch {
                result(.failure(error))
            }
        }}
        .subscribe(on: queue)
        .eraseToAnyPublisher()
    }
    
    public func getItem(id: String) -> AnyPublisher<domain.TaskModel, Error> {
        return Deferred { Future<TaskModel, Error> { [unowned self] result in
            do {
                if let m =  try db.getTaskBy(id: id) {
                    result(.success(m.toModel()) )
                    return
                }
                result(.failure(RepositoryError.notFound))
            } catch {
                result(.failure(error))
            }
        }}
        .subscribe(on: queue)
        .eraseToAnyPublisher()
    }
    
    public func save(_ task: domain.TaskModel) -> AnyPublisher<domain.TaskModel, Error> {
        
        return Deferred { Future<TaskModel, Error> { [unowned self] result in
            do {
                if (task.id == nil) {
                    let entity = task.toEntity(context: db.viewContext)
                    let model =  try db.saveTask(entity).toModel()
                    result(.success(model) )
                } else {
                    guard let entity = try db.getTaskBy(id: task.id!) else {
                        result(.failure(RepositoryError.notFound))
                        return
                    }
                    entity.update(model: task)
                    let model = try db.saveTask(entity).toModel()
                    result(.success(model) )
                    
                }
            } catch {
                result(.failure(error))
            }
        }}
        .subscribe(on: queue)
        .eraseToAnyPublisher()
        
    }
    
    public func remove(_ task: domain.TaskModel) -> AnyPublisher<Bool, Error> {
        
        return Deferred { Future<Bool, Error> { [unowned self] result in
            do {
                if let id = task.id {
                    try db.deleteTaskBy(id: id)
                    result(.success(true) )
                    return
                }
                result(.success(false) )
                
            } catch {
                result(.failure(error))
            }
        }}
        .subscribe(on: queue)
        .eraseToAnyPublisher()
        
    }
    
    
}
