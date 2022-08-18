//
//  CreateTaskScreen.swift
//  Todo
//
//  Created by Vitaly on 06.08.2022.
//

import SwiftUI




struct CreateTaskScreen: View {
    
    @StateObject var model: CreateTaskScreenViewModel

    var body: some View {
        VStack {
            NavBar(
                title: "New Task",
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




