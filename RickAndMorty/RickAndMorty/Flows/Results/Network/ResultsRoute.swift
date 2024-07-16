//
//  ResultsRoute.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

enum ResultsRoute {
    case character
}

extension ResultsRoute: Route {
    
    var endpoint: String {
        switch self {
        case .character: return Api.Endpoint.character.rawValue
        }
    }
}