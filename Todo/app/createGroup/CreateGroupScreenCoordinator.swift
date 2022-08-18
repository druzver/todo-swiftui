//
//  CreateGroupScreenCoordinator.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import UIKit
import SwiftUI
import domain

class CreateGroupScreenCoordinator: CoordinatorNode {
    
    
    private var onCreateComplete: ((TaskGroupModel) -> Void)?
    private weak var rootViewController: UIViewController?
    private var di: DIContainer
    init(complete: @escaping (TaskGroupModel) -> Void, di: DIContainer ) {
        self.di = di
        onCreateComplete = complete
    }
    
    override func start() {
        let vm = CreateGroupScreenModel(
            grpoupsRepository: di.groupsRepository
        )
        vm.navigation = self
        let view =  CreateGroupScreen(model: vm)
        present(rootView: view)
        
    }
    
    
    func present(rootView: some View) {
        let vc = UIHostingController(rootView: rootView )
        vc.modalPresentationStyle = .pageSheet
        
        navController.present(vc, animated: true)
        self.rootViewController = vc
    }
    
    
    override func stop() {
        onCreateComplete = nil
        rootViewController?.dismiss(animated: true)
        rootViewController = nil
    }
    
}

extension CreateGroupScreenCoordinator : CreateGroupScreenNavigation {
    
    func onSaveComplete(model: TaskGroupModel) {
        onCreateComplete?(model)
        parent?.removeChild(self)
    }
    
}
