//
//  CharacterResponse.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

struct CharacterListResponse: Decodable {
    let info: ListInfo
    let results: [CharacterResponse]

    enum CodingKeys: String, CodingKey {
        case info, results
    }
}

struct CharacterResponse: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let location: Location
    let episode: [String]
    let image: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, species, location, episode, image, url
    }
    
    struct Location: Decodable {
        let name: String
        let url: String
        
        enum CodingKeys: String, CodingKey {
            case name, url
        }
    }
}
