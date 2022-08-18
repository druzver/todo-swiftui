//
//  TaskListItemView.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI
import domain


struct TaskListItemView: View {
    
    var model: TaskModel
    
    var color: Color {
        model.color.toColor()
    }
    
    var onToggleComplition: () -> Void
    
    var body: some View {
        
            HStack(alignment: .top) {
                
                taskCheckBox
                
                Text(model.title)
                    .padding(.top, 5)
                    .foregroundColor(Color.black)
                
                Spacer()
                
                additionInfo
            }
            
            .padding(16)
            
            .background( RoundedRectangle(cornerRadius: 5)
                .fill(Color(0xffffff))
                .shadow(color: Color.black.opacity(0.2), radius: 5, y: 5)
            )
            
        
        .frame(maxWidth: .infinity)
        .padding(10)
        
    }
    
    private var additionInfo: some View  {
        VStack(spacing:5) {
            Text(model.date ?? Date(), style: .time)
                .font(.caption)
                .fontWeight(.bold)
            
            
            Image(systemName: "bell.fill")
                .foregroundColor(Color.black.opacity(0.5))
                .padding(.top, 10)
            
            
            Text(formatDuration(duration: model.remindBefore))
                .foregroundColor(Color.black.opacity(0.5))
                .font(.caption)
        }
    }
    
    private var taskCheckBox: some View {
        ColorView(
            color: model.color.toColor(),
            isChecked: model.completed,
            uncheckedImage: "circle"
        )
            .frame(width: 20, height: 20)
            .padding(5)
            .onTapGestureVibrate {
                onToggleComplition()
            }
    }
    
    private func formatDuration(duration: Int) -> String {
        return RemindDuratioin(rawValue: duration)?.toString() ?? "n/a"
    }
    
}


#if DEBUG

struct TaskListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let model = TaskModel(
            title: "Title some tesxdsfsdf\nsdfsdf\nsdf",
            date: Date(),
            remindBefore: 10,
            color: Color(0xff00ff).toInt(),
            groupId: nil,
            completed: false
        )
        
        
        
        let model2 = TaskModel(
            title: "Title some tesxdsfsdf\nsdfsdf\nsdf",
            date: Date(),
            remindBefore: 10,
            color: Color(0xffff00).toInt(),
            groupId: nil,
            completed: true
        )
        
        let model3 = TaskModel(
            title: "Title",
            date: Date(),
            remindBefore: 10,
            color: Color(0xff0000).toInt(),
            groupId: nil,
            completed: true
        )
        
        VStack(spacing:0) {
            TaskListItemView(model: model2, onToggleComplition: {})
            TaskListItemView(model: model, onToggleComplition: {})
            TaskListItemHeaderView(text: "header")
            TaskListItemView(model: model3, onToggleComplition: {})
        }
        
    }
}


#endif
