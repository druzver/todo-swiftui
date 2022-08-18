//
//  CreateGroupScreen.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import SwiftUI

struct CreateGroupScreen: View {
    
    @StateObject var model: CreateGroupScreenModel
    
    var body: some View {
        VStack {
            
            VStack {
                NavBar(
                    title: "New Group",
                    onBack: model.cancel,
                    onCreate: model.save
                )
                form
            }
            
        }.ignoresSafeArea(.keyboard)
            .alert(isPresented:  $model.showValidationError, content: { validationAlert })
        
    }
    
    var form: some View {
        Form() {
            TextField("Enter a group name", text: $model.name)
            
        }
    }
    
    var validationAlert: Alert {
        Alert(
            title: Text("Warning"),
            message: Text(model.errorMessage ?? ""),
            dismissButton: .cancel()
        )
    }
}


