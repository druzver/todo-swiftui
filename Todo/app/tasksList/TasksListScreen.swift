//
//  TasksListScreen.swift
//  Todo
//
//  Created by Vitaly on 09.08.2022.
//

import SwiftUI
import domain


struct UngroupedTasks: View {
    
    var title: String
    
    var tasks: [TaskModel]
    
    var onToggleTask: (TaskModel) -> Void
    var onTapTask: (TaskModel) -> Void
    var onDeleteTask: (TaskModel) -> Void
    
    var body: some View {
        Section(header: TaskListItemHeaderView(text: title) ) {

            ForEach(tasks) { item in
                TaskListItemView(
                    model: item,
                    onToggleComplition: {
                        onToggleTask(item)
                    }
                )
                .contextMenu() {
                    Button(action: {onDeleteTask(item)}) {
                        Label("Delete", systemImage: "trash")
                    }
                    
                }
                .onTapGesture {
                    onTapTask(item)
                }
            }
        }.frame(maxWidth: .infinity)
    }
}



struct TasksListScreen: View {
    
    @StateObject var viewModel: TasksListScreenViewModel
    
    var itemsList: some View {
        
        ScrollView {
            VStack {
                
                let ungroupedTasks = viewModel.getTasks(groupId: nil)
                
                if !ungroupedTasks.isEmpty {
                    UngroupedTasks(
                        title: "Ungrouped",
                        tasks: ungroupedTasks,
                        onToggleTask: viewModel.toggleCompletion,
                        onTapTask: viewModel.edit,
                        onDeleteTask: viewModel.deleteTask
                    )
                }
                
                ForEach( viewModel.groups, id: \.id ) { g in
                    
                    let tasks = viewModel.getTasks(groupId: g.id)
                    
                    if !tasks.isEmpty {
                        UngroupedTasks(
                            title: g.title,
                            tasks: tasks,
                            onToggleTask: viewModel.toggleCompletion,
                            onTapTask: viewModel.edit,
                            onDeleteTask: viewModel.deleteTask
                        )
                    }
                }
                
            }
        }
    }
    
    var calendarPanel: some View {
        
        ZStack(alignment: .center) {
            
            HStack(spacing:0) {
                
                Button(action: viewModel.prevDay) {
                    Image(systemName: "chevron.left")
                        .padding(10)
                }
                
                HStack {
                    Image(systemName: "calendar")
                        
                    Text(viewModel.date, style: .date)
                        
                }
                .font(.title2)
                .padding(.horizontal, 10)
                
                Button(action: viewModel.nextDay) {
                    Image(systemName: "chevron.right")
                        .padding(10)
                }
            }.foregroundColor(.black)
            
            
            HStack {
                Button(action: viewModel.today) {
                    Text("Today")
                }
                Spacer()
                Menu(content: {
                    Button(action: { viewModel.addGroup() } ) {
                        Text("Add tasks group")
                    }
                    
                }) {
                    Image(systemName: "gearshape")
                        .padding(10)
                }
                
                
                
               
            }
            
           
            
        }
        .frame(height: 40)
        .padding(10)
    }
    
    var body: some View {
        VStack {
            
            calendarPanel
            
            if viewModel.groupedTasks.isEmpty {
                EmptyTaskList()
            } else {
                itemsList
            }
            
            
        }.onAppear(perform: viewModel.onAppear)
        
    }
    
}

