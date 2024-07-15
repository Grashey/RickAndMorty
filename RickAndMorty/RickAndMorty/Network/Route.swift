//
//  Route.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 14.07.2024.
//

import Foundation

protocol Route {
    var method: String { get }
    var baseUrl: String { get }
    var endpoint: String { get }
}

extension Route {
    var method: String { "GET" }
    var baseUrl: String { Api.baseUrl }

    func makeURL(_ path: String? = nil) -> String {
        guard let path = path else { return baseUrl.appending(endpoint) }
        return path
    }
}
