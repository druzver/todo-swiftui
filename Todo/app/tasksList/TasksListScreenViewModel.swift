//
//  TasksListScreenViewModel.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import Foundation
import domain
import Combine

class TasksListScreenViewModel : ObservableObject {
    
    @Published var groups: [TaskGroupModel] = []
    @Published var date: Date
    @Published var showCompleted = true
    @Published var groupedTasks: Dictionary<String?, [TaskModel]> = [:]
    
    private var store: TasksRepository
    private var groupsRepository: TaskGroupsRepository
    
    weak var navigation: TasksListScreenNavigation?
    
    private var disposeBag = Set<AnyCancellable>()
    
    
//    let notifications = NotificationModel()
   
    private let useCaseTaskNotification: UseCaseTaskNotification
    
    init(store: TasksRepository, groupsRepository: TaskGroupsRepository,
         useCaseTaskNotification :UseCaseTaskNotification
    ) {
        self.useCaseTaskNotification = useCaseTaskNotification
        self.store = store
        self.groupsRepository = groupsRepository
        self.date = Date()
        
    }
    
    func getTasks(groupId: String?) -> [TaskModel] {
        return groupedTasks[groupId] ?? []
    }
    
    func today() {
        setDate(date: Date())
    }
    
    func setDate(date: Date) {
        self.date = date
        refresh()
    }
    
    func nextDay() {
        date = date.nextDay
        refresh()
    }
    
    func prevDay() {
        date = date.prevDay
        refresh()
    }
    
    func edit(_ item: TaskModel) {
        guard let id = item.id else { return }
        navigation?.goToEditTask(taskId: id, completion: { [weak self] in
            // self?.refresh()
        })
        
    }
    
    
    func toggleCompletion(_ task: TaskModel) {
        
        var newValue = task
        newValue.toggleCompletion()
        
    
        store.save(newValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                //todo: process error
                self?.refresh()
            }, receiveValue: { [weak self] task in
                self?.useCaseTaskNotification.update(taskModel: task, completion: { _ in } )
                
            })
            .store(in: &disposeBag)
        

        
    }
    
    func deleteTask(_ task: TaskModel) {
        
        store.remove(task)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] _ in
                //todo: process error
                self?.refresh()
            }, receiveValue: {_ in })
            .store(in: &disposeBag)
        
       
        
    }

    func addTask() {
        navigation?.goToCreateTask(groupId: nil, date: date, completion: { [weak self] in
            // self?.refresh()
        })
    }
    
    
    
    
    
    func onAppear() {
        
        
        groupsRepository.getItems()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in }, receiveValue: { [weak self] groups in
                self?.groups = groups
                self?.refresh()
            }).store(in: &disposeBag)
        
        
    }
    
    func toggleShowCompleted() {
        showCompleted.toggle()
        refresh()
    }
    
    func refresh() {
        let fromDate = date.startOfDay
        let toDate = date.endOfDay
        
        let filter = TasksRepositoryFilter(
            showComplited: showCompleted,
            betweenDates: fromDate...toDate,
            groupId: nil
        )
        
        store.getItems(filter: filter)
            .map() { items in
                return Dictionary(grouping: items, by: { $0.groupId })
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in }, receiveValue: { [weak self] in
                self?.groupedTasks = $0
            }).store(in: &disposeBag)
        
    }

    
    func addGroup() {
        navigation?.goToCreateGroup() { [weak self] g in
            self?.groups.append(g)
        }
    }
    
    func selectGroup(_ group: TaskGroupModel?) {
        //refresh()
    }
    
    
}

