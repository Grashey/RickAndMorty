//
//  CoreDataStack.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 18.07.2024.
//

import Foundation
import CoreData

class CoreDataStack {
    
    private let container: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    private lazy var backgroundContext: NSManagedObjectContext = container.newBackgroundContext()
    private var coordinator: NSPersistentStoreCoordinator { container.persistentStoreCoordinator }
    private let characterFetchRequest = Character.fetchRequest()
    private let locationFetchRequest = Location.fetchRequest()
    private let episodeFetchRequest = Episode.fetchRequest()
    
    init(modelName: String) {
        let container = NSPersistentContainer(name: modelName)
        self.container = container
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let url = URL(fileURLWithPath: documentsPath).appendingPathComponent("RM_Entity.sqlite")
        
        do {
            try container.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                                        configurationName: nil,
                                                                        at: url,
                                                                        options: [NSMigratePersistentStoresAutomaticallyOption: true,
                                                                                        NSInferMappingModelAutomaticallyOption: true])
        } catch {
            print(error.localizedDescription)
            fatalError()
        }
        
        self.mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.mainContext.persistentStoreCoordinator = coordinator
        
        self.backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        self.backgroundContext.persistentStoreCoordinator = coordinator
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(contextDidChange(notification:)),
                                               name: Notification.Name.NSManagedObjectContextDidSave,
                                               object: self.backgroundContext)
    }
}

extension CoreDataStack: DataKeeper {
    
    func addCharacter(id: Int, name: String, status: String, species: String, location: String, url: String) {
        mainContext.performAndWait {
            let entity = Character(context: mainContext)
            entity.id = Int16(id)
            entity.name = name
            entity.status = status
            entity.species = species
            entity.location = location
            entity.url = url
            try? mainContext.save()
        }
    }
    
    func updateCharacter(id: Int, imageData: Data) {
        characterFetchRequest.predicate = .init(format: "id == '\(id)'")
        mainContext.performAndWait {
            if let character = try? characterFetchRequest.execute().first {
                character.image = imageData
            }
            try? mainContext.save()
        }
    }
    
    func updateCharacter(id: Int, episode: String) {
        characterFetchRequest.predicate = .init(format: "id == '\(id)'")
        mainContext.performAndWait {
            if let character = try? characterFetchRequest.execute().first {
                character.episode = episode
            }
            try? mainContext.save()
        }
    }
    
    func addLocation(id: Int, name: String) {
        mainContext.performAndWait {
            let entity = Location(context: mainContext)
            entity.id = Int16(id)
            entity.name = name
            try? mainContext.save()
        }
    }
    
    func addEpisode(id: Int, name: String) {
        mainContext.performAndWait {
            let entity = Episode(context: mainContext)
            entity.id = Int16(id)
            entity.name = name
            try? mainContext.save()
        }
    }
    
}

extension CoreDataStack {
    @objc func contextDidChange(notification: Notification) {
        coordinator.performAndWait {
            mainContext.performAndWait {
                mainContext.mergeChanges(fromContextDidSave: notification)
            }
        }
    }
}

extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
