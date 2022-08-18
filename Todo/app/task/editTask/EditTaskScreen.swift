//
//  EditTaskScreen.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import SwiftUI



struct EditTaskScreen: View {
    
    @StateObject var model: EditTaskScreenViewModel
    
    var body: some View {
        VStack {
            NavBar(
                title: "Edit Task",
                createText: "Save",
                onBack: model.goBack,
                onCreate: model.save
            )
            if model.loading {
                LoadingView()
            } else {
                TaskEditFormView(model: model)
            }
        }
        .onAppear() {
            model.onAppear()
        }
        .ignoresSafeArea(.keyboard)
        .alert(isPresented:  $model.isPresentValidation, content: { validationAlert })
        
    }
    
    var validationAlert: Alert {
        Alert(
            title: Text("Warning"),
            message: Text(model.validationMessage ?? ""),
            dismissButton: .cancel()
        )
    }
}


struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Loading")
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
    }
}
