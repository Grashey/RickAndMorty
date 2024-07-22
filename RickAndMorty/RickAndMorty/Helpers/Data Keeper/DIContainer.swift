//
//  DIContainer.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 18.07.2024.
//

import Foundation

class Container {
    static let shared = Container()
    private init() {}

    lazy var coreDataStack = CoreDataStack(modelName: "CoreDataModel")
}
