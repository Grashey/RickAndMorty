//
//  ListResponse.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 14.07.2024.
//

import Foundation

struct ListResponse: Decodable {
    let info: ListInfo
    let results: [ResultResponse]

    enum CodingKeys: String, CodingKey {
        case info, results
    }
}

struct ListInfo: Decodable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
    
    enum CodingKeys: String, CodingKey {
        case count, pages, next, prev
    }
}

struct ResultResponse: Decodable {
    let id: Int
    let name: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, url
    }
}
