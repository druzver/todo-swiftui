//
//  File.swift
//  
//
//  Created by Vitaly on 09.08.2022.
//

import Foundation
import CoreData

public class CoreDataManager : NSPersistentContainer {
    
    
    public init() {
        
        guard let objectModelURL = Bundle.module.url(forResource:"Model", withExtension: "momd") else {
            fatalError("Failed to retrieve the object model")
        }

        guard let objectModel = NSManagedObjectModel(contentsOf: objectModelURL) else {
            fatalError("Failed to retrieve the object model")
        }
        
        super.init(name: "Model", managedObjectModel: objectModel)
        
        initialize()
    }
    
    private func initialize() {
           self.loadPersistentStores { description, error in
               if let err = error {
                   fatalError("Failed to load CoreData: \(err)")
               }
               print("Core data loaded: \(description)")
           }
       }

}

