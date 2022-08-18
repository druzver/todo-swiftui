//
//  EditTaskFormModel.swift
//  Todo
//
//  Created by Vitaly on 12.08.2022.
//

import SwiftUI
import domain

class EditTaskFormModel: ObservableObject {
    @Published var name: String = ""
    @Published var color: Color = .red
    @Published var groups: [TaskGroupModel] = []
    @Published var remindBefore: RemindDuratioin = .minutes30
    @Published var groupId: String? = nil
    @Published var completed: Bool = false
    @Published var date: Date = Date()
    @Published var loading: Bool = true
    
    @Published var isPresentValidation: Bool = false
    var validationMessage: String?
    
    let dateRange = Date()...Date(timeIntervalSinceNow: 60 * 60 * 24 * 365)
    let allowedColors = [
        Color(0xff0000),
        Color(0xF7CF51),
        Color(0xA66CFF),
        Color(0xB1E1FF),
        Color(0x377D71),
    ]
}
