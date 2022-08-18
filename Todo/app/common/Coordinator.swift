//
//  Coordinator.swift
//  Todo
//
//  Created by Vitaly on 06.08.2022.
//

import Foundation

import UIKit
import SwiftUI


protocol Coordinator : AnyObject {

    func start()
    func stop()
    
}


class CoordinatorNode : Coordinator {
    
    private var children: [CoordinatorNode] = []
    weak var parent: CoordinatorNode?

    lazy var navController: UINavigationController = {
        guard let ctrl = self.parent?.navController else { fatalError("Navigation controller is undefined") }
        return ctrl
    }()

    
    func present(_ child: CoordinatorNode) {
        addChild(child)
        child.start()
    }
    
    func addChild(_ child: CoordinatorNode) {
        child.parent = self
        children.append(child)
    }
    
    func removeChild(_ child: CoordinatorNode) {
        guard let index = children.firstIndex(where: {child === $0}) else {
            return
        }
        child.stop()
        child.parent = nil
        children.remove(at: index)
    }
    
    func start() {
        //todo:
    }

    func stop() {
        //
    }
    
    func goBack() {
        parent?.removeChild(self)
    }
    
    

}
