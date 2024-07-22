//
//  Location+CoreDataProperties.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 18.07.2024.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var characters: NSSet?

}

// MARK: Generated accessors for characters
extension Location {

    @objc(addCharactersObject:)
    @NSManaged public func addToCharacters(_ value: Character)

    @objc(removeCharactersObject:)
    @NSManaged public func removeFromCharacters(_ value: Character)

    @objc(addCharacters:)
    @NSManaged public func addToCharacters(_ values: NSSet)

    @objc(removeCharacters:)
    @NSManaged public func removeFromCharacters(_ values: NSSet)

}

extension Location : Identifiable {

}
