//
//  TaskEditFormView.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI




struct TaskEditFormView: View {
    
    @StateObject var model: EditTaskFormModel
    
    var sectionText: some View {
        Section(header: Text("Todo text")) {
            
            TextEditor(text: $model.name)
                .lineLimit(10)
                .frame(minHeight: 100)
        }
    }
    
    var sectionColors: some View {
        Section(header: Text("Colors")) {
            ColorsPicker(selectedColor: $model.color, colors: model.allowedColors)
        }
    }
    
    var sectionComplited: some View {
        Section(header: Text("Completion")) {
            Toggle("Completed", isOn: $model.completed)
        }
    }
    
    var sectionGroup: some View {
        Section(header: Text("Group")) {
            
            Picker("Group", selection: $model.groupId) {
                Text("Ungrouped").tag(Optional<String>(nil))
                
                ForEach(model.groups) { group in
                    Text(group.title).tag(group.id)
                }
            }.pickerStyle(.inline)
        }
       
    }
    
    
    var sectionPreferences: some View {
        
        Section(header: Text("Preferences")) {
            
            DatePicker(selection: $model.date, in: model.dateRange, displayedComponents: .date) {
                Text("Date")
            }
            
            DatePicker(selection: $model.date,  displayedComponents: .hourAndMinute) {
                Text("Time")
            }

            Picker("Remind", selection: $model.remindBefore) {
                ForEach(RemindDuratioin.allCases, id:\.self) { i in
                    Text(i.toString()).tag(i)
                }
                
                
            }.pickerStyle(.inline)
        }
    }
    
    var body: some View {
        Form {
            sectionText
            sectionColors
            sectionGroup
            sectionComplited
            sectionPreferences
            
        }.modifier(HideKeyboardOnDrag())
        
    }
}



struct TaskEditFormView_Previews: PreviewProvider {
    static var previews: some View {
        TaskEditFormView(model: EditTaskFormModel())
    }
}
