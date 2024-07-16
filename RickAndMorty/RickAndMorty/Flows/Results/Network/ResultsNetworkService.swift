//
//  ResultsNetworkService.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

protocol iResultsNetworkService {
    func fetchCharacters(filter: FilterModel, page: Int) async throws -> Data
}

class ResultsNetworkService: iResultsNetworkService {
    
    private let httpClient: iHTTPClient
    private let requestBuilder: iRequestBuilder
    
    init(httpClient: iHTTPClient, requestBuilder: iRequestBuilder) {
        self.httpClient = httpClient
        self.requestBuilder = requestBuilder
    }
    
    func fetchCharacters(filter: FilterModel, page: Int) async throws -> Data {
        var parameters: [String : Any] = ["page": page,
                          "status": filter.status.rawValue]
        if let name = filter.name {
            parameters["name"] = name
        }
        if let species = filter.species {
            parameters["species"] = species
        }
        let request = requestBuilder.makeRequest(route: ResultsRoute.character, parameters: parameters)
        let response = try await httpClient.send(request: request)
        return response.data
    }
    
}
