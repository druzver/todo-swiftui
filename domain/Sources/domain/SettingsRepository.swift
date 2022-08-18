//
//  File.swift
//  
//
//  Created by Vitaly on 12.08.2022.
//

import Foundation
import Combine

public struct SettingsModel : Codable {
    
    public var showCompleted: Bool
    
    public  init(showCompleted: Bool) {
        self.showCompleted = showCompleted
    }
    
}

public protocol SettingsRepository {
    
    func getSettings() -> SettingsModel
    
    func saveSettings(_ model: SettingsModel)
    
    func getSettingsStream() -> AnyPublisher<SettingsModel,Error>
}
