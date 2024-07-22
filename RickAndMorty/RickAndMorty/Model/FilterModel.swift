//
//  FilterModel.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 08.07.2024.
//

import Foundation

struct FilterModel {
    var name: String?
    var status: Status
    var species: Species?
    var location: DropListModel
    var appearance: DropListModel
}

enum Status: String {
    case dead = "Dead"
    case alive = "Alive"
}

enum Species: String {
    case alien = "Alien"
    case human = "Human"
    case robot = "Robot"
}
