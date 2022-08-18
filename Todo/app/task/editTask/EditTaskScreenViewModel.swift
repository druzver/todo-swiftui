//
//  EditTaskScreenViewModel.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import SwiftUI
import domain
import Combine



class EditTaskScreenViewModel :  EditTaskFormModel  {
    
    
    
    
    var navigation:CreateTaskScreenNavigation?
    
    private var tasksRepository: TasksRepository
    private var groupsRepository: TaskGroupsRepository
    private var taskId: String
    
    private var disposeBag = DispposeBag()
    private let useCaseTaskNotification :UseCaseTaskNotification
    
    init(taskId: String, tasksRepository: TasksRepository, groupsRepository: TaskGroupsRepository, useCaseTaskNotification :UseCaseTaskNotification) {
        self.useCaseTaskNotification = useCaseTaskNotification
        self.tasksRepository = tasksRepository
        self.groupsRepository = groupsRepository
        self.taskId = taskId
        
    }

    func onAppear() {
        
        //Publishers.CombineLatest has a bug
        Publishers.Zip(groupsRepository.getItems(), tasksRepository.getItem(id: taskId))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] r in
                self?.loading = false
            }, receiveValue: { [weak self] groups, task in
                self?.groups = groups
                self?.name = task.title
                self?.groupId = task.groupId
                self?.remindBefore = .init(rawValue: task.remindBefore) ?? .minutes30
                self?.completed = task.completed
                self?.color = task.color.toColor()
                self?.date = task.date ?? Date()
            }).store(in: &disposeBag)
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
            id: self.taskId,
            title: name,
            date: date,
            remindBefore: remindBefore.rawValue,
            color: self.color.toInt(),
            groupId: groupId,
            completed: completed
        )
        
        //MARK: todo validation
        
        tasksRepository.save(newTask)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: onSaveCompletion, receiveValue: { [weak self] task in
                self?.useCaseTaskNotification.update(taskModel: task, completion: { _ in })
            })
            .store(in: &disposeBag)
        
    }
    
    func onSaveCompletion(completion: Subscribers.Completion<Error>) {
        switch(completion) {
        case .finished:
            self.navigation?.onSaveComplete()
        case .failure(let e):
            print(e.localizedDescription)
        }
    }
    
    func toggleCompleted() {
        completed = true
        save()
    }
    
    func goBack() {
        navigation?.goBack()
    }
    
}
