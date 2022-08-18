//
//  File.swift
//  
//
//  Created by Vitaly on 17.08.2022.
//

import Foundation
import Combine

public class UseCaseFetchTasksCountForPeriod {

    public typealias Result = Dictionary<Int, Int>
    
    private var tasksRepository: TasksRepository
    
    public init(tasksRepository: TasksRepository) {
        self.tasksRepository = tasksRepository
    }
    
    public func fetch(startDate: Date, endDate: Date) -> AnyPublisher<Result, Error> {
        let filter = TasksRepositoryFilter(showComplited: true, betweenDates: startDate...endDate)
        
        return tasksRepository.getItems(filter: filter)
            .map() { tasks in
                Dictionary(grouping: tasks) {
                    $0.date?.day ?? 0
                }.mapValues() { $0.count }
                
            }
            .eraseToAnyPublisher()
    }
}
