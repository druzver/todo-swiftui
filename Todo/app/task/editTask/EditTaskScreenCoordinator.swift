//
//  EditTaskScreenCoordinator.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import UIKit
import SwiftUI
import data
import domain


class EditTaskScreenCoordinator : CoordinatorNode , CreateTaskScreenNavigation {
    
    private var taskId: String
    private var createCompletion: () -> Void

    private var di: DIContainer
    
    init(taskId: String, completion: @escaping () -> Void, di: DIContainer) {
        self.di = di
        self.taskId = taskId
        self.createCompletion = completion
    }
    
    override func start() {
        
        let vm = EditTaskScreenViewModel(
            taskId: taskId,
            tasksRepository: di.tasksRepository,
            groupsRepository: di.groupsRepository,
            useCaseTaskNotification: UseCaseTaskNotification(notificationManager: di.notificationManager)
        )
        
        vm.navigation = self
                
        present(rootView: EditTaskScreen(model: vm))
    }
    
    override func stop() {
        navController.topViewController?.dismiss(animated: true)
    }
    
    private func present(rootView: some View) {
        let vc = UIHostingController(rootView: rootView )
        vc.modalPresentationStyle = .fullScreen
        navController.present(vc, animated: true)
    }
    
    
    func onSaveComplete() {
        createCompletion()
        goBack()
    }
    
}

