//
//  File.swift
//  
//
//  Created by Vitaly on 12.08.2022.
//

import Foundation
import Combine
import domain

class SettingsStore {
    
    private var KEY = "app-settings"
    
    private var store: UserDefaults
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    init(store: UserDefaults = UserDefaults.standard) {
        self.store = store
    }
    
    func getSettings() throws -> SettingsModel? {
        if let data = store.data(forKey: KEY) {
            return try decoder.decode(SettingsModel.self, from: data)
        }
        return nil
    }
    
    func saveSettings(_ model: SettingsModel) throws {
        let data = try encoder.encode(model)
        store.set(data, forKey: KEY)
        
    }
    
    
}



public class SettingsRepositoryImpl : SettingsRepository {
   
    
    
    @Published var settings: SettingsModel?
    
    private var store: SettingsStore = SettingsStore()
    
    init() {
  
    }
    

    
    public func getSettings() -> domain.SettingsModel {
        if self.settings == nil {
            self.settings = (try? store.getSettings()) ?? SettingsModel(showCompleted: false)
        }
        
        return self.settings!
    }
    
    public func saveSettings(_ model: domain.SettingsModel) {
        self.settings = model
        try? store.saveSettings(model)
    }
    
    
    public func getSettingsStream() -> AnyPublisher<domain.SettingsModel, Error> {
//        return _settings
        fatalError("error")
    }
    

    
}
