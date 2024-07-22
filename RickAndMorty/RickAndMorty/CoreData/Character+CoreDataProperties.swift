//
//  Character+CoreDataProperties.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 18.07.2024.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var location: String?
    @NSManaged public var episode: String?
    @NSManaged public var image: Data?
    @NSManaged public var url: String?
    @NSManaged public var lastLocation: Location?
    @NSManaged public var firstEpisode: Episode?

}

extension Character : Identifiable {

}
