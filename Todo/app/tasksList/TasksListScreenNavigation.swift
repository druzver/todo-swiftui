//
//  TasksListScreenNavigation.swift
//  Todo
//
//  Created by Vitaly on 17.08.2022.
//

import Foundation
import domain


protocol TasksListScreenNavigation : AnyObject {
    
    func goToEditTask(taskId: String, completion: @escaping () -> Void )
    
    func goToEditGroup(groupId: String, completion: @escaping (TaskGroupModel) -> Void )
    
    func goToCreateGroup(completion: @escaping (TaskGroupModel) -> Void )
    
    func goToCreateTask(groupId:String?, date: Date, completion: @escaping () -> Void )
    
}

