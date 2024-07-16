//
//  EpisodeResponse.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 16.07.2024.
//

import Foundation

struct EpisodeResponse: Decodable {
    let id: Int
    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, name, url
    }
}
