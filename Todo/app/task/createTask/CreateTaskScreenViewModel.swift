//
//  CreateTaskScreenViewModel.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import Foundation
import domain
import SwiftUI
import Combine

typealias DispposeBag = Set<AnyCancellable>


class CreateTaskScreenViewModel : EditTaskFormModel  {
    
    weak var navigation: CreateTaskScreenNavigation?
    private var tasksRepository: TasksRepository
    private var groupsRepository: TaskGroupsRepository
    private var disposeBag = DispposeBag()
    private let useCaseTaskNotification :UseCaseTaskNotification
    
    init(groupId: String?, date: Date?, tasksRepository: TasksRepository, groupsRepository: TaskGroupsRepository, useCaseTaskNotification :UseCaseTaskNotification ) {
        self.useCaseTaskNotification = useCaseTaskNotification
        
        self.tasksRepository = tasksRepository
        self.groupsRepository = groupsRepository
        
        super.init()
        
        self.groupId = groupId
        self.color = allowedColors.first!
        self.date = date ?? Date(timeIntervalSinceNow: 60)
    }

    func onAppear() {
        
        name = ""
        date =  self.date
        
        groupsRepository.getItems()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.loading = false
            }, receiveValue: { [weak self] groups in
                self?.onGroupsFetchComplete(groups)
            }).store(in: &disposeBag)
    }
    
    private func onGroupsFetchComplete(_ groups: [TaskGroupModel]) {
        self.groups = groups
        groupId = groupId ?? groups.first?.id
    }
    
    func cancel() {
        navigation?.goBack()
    }
    
    private func validate() -> Bool {
        if name.isEmpty {
            validationMessage = "Please enter text"
            return false
        }
        return true
    }
    
    func save() {
        
        if validate() == false {
            isPresentValidation = true
            return
        }
        
        let newTask = TaskModel(
            title: name,
            date: date,
            remindBefore: remindBefore.rawValue,
            color: color.toInt(),
            groupId: groupId,
            completed: completed)
        
        tasksRepository.save(newTask)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                self?.loading = false
            }, receiveValue: { [weak self] model in
                self?.useCaseTaskNotification.create(taskModel: model, completion: { _ in })
                self?.navigation?.onSaveComplete()
            })
            .store(in: &disposeBag)
        
    }
    
    func goBack() {
        navigation?.goBack()
    }
    
}





