//
//  CreateTaskScreenCoordinator.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import UIKit
import SwiftUI
import domain


class CreateTaskScreenCoordinator : CoordinatorNode , CreateTaskScreenNavigation {
   
    
    private var createCompletion: () -> Void
    private var taskGroupId: String?
    private var date: Date
    private var di: DIContainer
    
    init(taskGroupId: String?, date: Date, completion: @escaping () -> Void, di: DIContainer) {
        self.di = di
        self.taskGroupId = taskGroupId
        self.createCompletion = completion
        self.date = date
    }
    
    override func start() {
        let vm = CreateTaskScreenViewModel(
            groupId: taskGroupId,
            date: date,
            tasksRepository: di.tasksRepository,
            groupsRepository: di.groupsRepository,
            useCaseTaskNotification: UseCaseTaskNotification(notificationManager: di.notificationManager)
        )
        vm.navigation = self
        
        present(rootView: CreateTaskScreen(model: vm))
    }
    
    
    func present(rootView: some View) {
        let vc = UIHostingController(rootView: rootView )
        vc.modalPresentationStyle = .fullScreen
        navController.present(vc, animated: true)
    }
    
    
    override func stop() {
        navController.topViewController?.dismiss(animated: true)
    }
    
    
    func onSaveComplete() {
        createCompletion()
        goBack()
    }
    
}
