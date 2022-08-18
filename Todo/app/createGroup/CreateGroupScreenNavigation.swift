//
//  CreateGroupScreenNavigation.swift
//  Todo
//
//  Created by Vitaly on 17.08.2022.
//

import Foundation
import domain

protocol CreateGroupScreenNavigation: AnyObject {
    func onSaveComplete(model: TaskGroupModel)
    func goBack()
}
