//
//  CalendarScreenViewModel.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI
import domain



class CalendarScreenViewModel: ObservableObject {
    
    var monthRange = -100...100
    
    private var taskRepo: TasksRepository
    
    weak var navigation: CalendarScreenNavigation?
    
    init(taskRepo: TasksRepository) {
        self.taskRepo = taskRepo
    }
    
    func getItem(index: Int) -> CalendarMonthViewModel {
        let startDate = Date().startOfMonth.addMonthes(index)
        let endDate = startDate.endOfMonth
        let useCase = UseCaseFetchTasksCountForPeriod(tasksRepository: taskRepo)

        let model = CalendarMonthViewModel(
            useCase: useCase,
            startDate: startDate,
            endDate: endDate
        )
        return model
    }
    
    func selectDate(_ date: Date) {
        navigation?.goToTasks(date: date)
    }
    
}
