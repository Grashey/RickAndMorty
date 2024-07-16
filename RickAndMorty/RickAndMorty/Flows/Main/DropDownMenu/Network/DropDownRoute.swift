//
//  DropDownRoute.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 14.07.2024.
//

import Foundation

enum DropDownRoute {
    case locations
    case episodes
}

extension DropDownRoute: Route {
    
    var endpoint: String {
        switch self {
        case .episodes: return Api.Endpoint.episode.rawValue
        case .locations: return Api.Endpoint.location.rawValue
        }
    }
}
