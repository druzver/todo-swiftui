//
//  File.swift
//  
//
//  Created by Vitaly on 11.08.2022.
//

import Foundation


public class DI {
    
    static public var shared: DI = { return DI() }()
    
    private init() {}
    
    
    public lazy var coreDataManager: CoreDataManager = {
        return CoreDataManager()
    }()
    
    
    public lazy var dbProvider: TasksCoreDataProvider = {
        return TasksCoreDataProviderImpl(coreDataManager: coreDataManager)
    }()
    
}
