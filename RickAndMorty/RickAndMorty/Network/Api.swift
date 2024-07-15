//
//  Api.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 14.07.2024.
//

import Foundation

enum Api {
    
    static let baseUrl = "https://rickandmortyapi.com/api"

    enum Endpoint: String {
        case character = "/character"
        case location = "/location"
        case episode = "/episode"
    }
}
