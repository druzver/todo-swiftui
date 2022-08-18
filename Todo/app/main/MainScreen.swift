//
//  MainScreen.swift
//  Todo
//
//  Created by Vitaly on 06.08.2022.
//

import SwiftUI
import domain

struct MainScreen : View {
    
    @StateObject var model: MainScreenViewModel
    
    //no need to react on any changes
    var taskListViewModel: TasksListScreenViewModel
    var calendarViewModel: CalendarScreenViewModel
    
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                if(model.selectedTab == 0) {
                    TasksListScreen(viewModel: taskListViewModel)
                }
                
                if(model.selectedTab == 1) {
                    CalendarScreen(viewModel: calendarViewModel)
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            BottomBarNavigationView(selectedItem: $model.selectedTab, onAdd: {
                taskListViewModel.addTask()
            })
        }
        .navigationBarHidden(true)
        .background(Color.white)
            .onAppear() { model.onAppear() }
            .onDisappear() { model.onDisapear()}
        
    }
}






class MainScreenViewModel: ObservableObject {
    
    weak var navigation: MainScreenNavigation?
    
    @Published var selectedTab: Int
    
    var notificationIsGranted: Bool = false
    
    var notificationManager: NotificationManager
    
    init(notificationManager: NotificationManager) {
        self.notificationManager = notificationManager
        selectedTab = 0
    }
    
    func onAppear() {
        if (!notificationIsGranted) {
            authorizeToUseNotifications()
        }
    }
    
    func authorizeToUseNotifications() {
        notificationManager.requestAuthorization(completion: { [weak self] isGranted in
            self?.notificationIsGranted = isGranted
        })
    }
    
    func onDisapear() {
        //
    }
    
    func showSettings() {
        selectedTab = 3
    }
    
    func createNewTask() {
        navigation?.goToCtreateTask()
    }
    
}

protocol MainScreenNavigation: AnyObject {
    
    func goToCtreateTask()
    
}


