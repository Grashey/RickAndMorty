//
//  DropDownNetworkService.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 14.07.2024.
//

import Foundation

protocol iDropDownNetworkService {
    func fetchLocations(page: Int) async throws -> Data
    func fetchEpisodes(page: Int) async throws -> Data
}

class DropDownNetworkService: iDropDownNetworkService {
    
    private let httpClient: iHTTPClient
    private let requestBuilder: iRequestBuilder
    
    init(httpClient: iHTTPClient, requestBuilder: iRequestBuilder) {
        self.httpClient = httpClient
        self.requestBuilder = requestBuilder
    }
    
    func fetchLocations(page: Int) async throws -> Data {
        let parameters = ["page": page]
        let request = requestBuilder.makeRequest(route: DropDownRoute.locations, parameters: parameters)
        let response = try await httpClient.send(request: request)
        return response.data
    }
    
    func fetchEpisodes(page: Int) async throws -> Data {
        let parameters = ["page": page]
        let request = requestBuilder.makeRequest(route: DropDownRoute.episodes, parameters: parameters)
        let response = try await httpClient.send(request: request)
        return response.data
    }
}
