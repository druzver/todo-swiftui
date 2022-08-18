//
//  CreateGroupScreenModel.swift
//  Todo
//
//  Created by Vitaly on 11.08.2022.
//

import Foundation
import domain
import Combine

class CreateGroupScreenModel : ObservableObject {
    
    private var grpoupsRepository: TaskGroupsRepository
    
    @Published var name: String = ""
    @Published var showValidationError: Bool = false
    var errorMessage: String?
    
    private var disposeBag = Set<AnyCancellable>()
    
    weak var navigation: CreateGroupScreenNavigation?
    
    init(grpoupsRepository: TaskGroupsRepository) {
        self.grpoupsRepository = grpoupsRepository
    }
    
    
    func save() {
        
        if name.isEmpty {
            errorMessage = "Group name can't be empty"
            showValidationError = true
            return
        }
        
        
        let g = TaskGroupModel(title: name)
        
        grpoupsRepository.save(g)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in }, receiveValue: { [weak self] model in
                print("Thread", Thread.current.isMainThread ? "Main" : "BG")
                self?.navigation?.onSaveComplete(model: model)
            }).store(in: &disposeBag)
            
    }
    
    func cancel() {
        navigation?.goBack()
    }
    
    
}

