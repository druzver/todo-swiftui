//
//  MainScreenCoordinator.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import UIKit
import SwiftUI
import domain


class MainScreenCoordinator : CoordinatorNode, MainScreenNavigation, CalendarScreenNavigation {
    
    
    private var di: DIContainer
    
    init(navController: UINavigationController, di: DIContainer) {
        self.di = di
        
        super.init()
        self.navController = navController
        navController.navigationBar.prefersLargeTitles = false
        navController.isNavigationBarHidden = true
    }
    
    private var model: MainScreenViewModel?

    private var calendarViewModel: CalendarScreenViewModel?
    private var taskListViewModel: TasksListScreenViewModel?
    
    override func start() {
        
        let tasksRepo = di.tasksRepository
        
        let taskListViewModel = TasksListScreenViewModel(
            store: tasksRepo,
            groupsRepository: di.groupsRepository,
            useCaseTaskNotification: UseCaseTaskNotification(notificationManager: di.notificationManager)
        )
        taskListViewModel.navigation = self
        self.taskListViewModel = taskListViewModel
        
        let model = MainScreenViewModel(notificationManager: di.notificationManager)
        model.navigation = self
        
      
        
        
        let calendarVM = CalendarScreenViewModel(taskRepo: tasksRepo)
        calendarVM.navigation = self
        calendarViewModel = calendarVM
        
        let view = MainScreen(
            model: model,
            taskListViewModel: taskListViewModel,
            calendarViewModel: calendarVM
        )
        
        let ctrl = UIHostingController(rootView: view)
    
        navController.setViewControllers([ctrl], animated: false)
        
        
        self.model = model
        
    }
    
    func goToTasks(date: Date) {
        model?.selectedTab = 0
        taskListViewModel?.setDate(date: date)
        
    }
    
    
    func goToCtreateTask() {
        
        
        
    }
    
    
    
    
}





extension MainScreenCoordinator : TasksListScreenNavigation {
    
    
    func goToEditGroup(groupId: String, completion: @escaping (domain.TaskGroupModel) -> Void) {
        //
    }
    
    func goToCreateGroup(completion: @escaping (domain.TaskGroupModel) -> Void) {
        
        let coordinator = CreateGroupScreenCoordinator(complete: completion, di: di)
        
        present(coordinator)
    }
    
    func goToEditTask(taskId: String, completion: @escaping () -> Void) {
        let coordinator = EditTaskScreenCoordinator(taskId: taskId, completion: completion, di: di)
        present(coordinator)
    }
    
    func goToCreateTask(groupId: String?, date: Date, completion: @escaping () -> Void) {
        let coordinator = CreateTaskScreenCoordinator(taskGroupId: groupId, date: date, completion: completion, di: di)
        present(coordinator)
    }

    
}
