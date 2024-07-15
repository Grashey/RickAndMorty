//
//  RequestBuilder.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 14.07.2024.
//

import Foundation

protocol iRequestBuilder {
    func makeRequest(route: Route, parameters: [String: Any]?, path: String?) -> URLRequest
}

extension iRequestBuilder {
    
    func makeRequest(route: Route, parameters: [String: Any]? = nil, path: String? = nil) -> URLRequest {
        makeRequest(route: route, parameters: parameters, path: path)
    }
}

final class RequestBuilder: iRequestBuilder {

    func makeRequest(route: Route, parameters: [String: Any]? = nil, path: String? = nil) -> URLRequest {
        var components = URLComponents(string: route.makeURL(path))
        if let parameters = parameters {
            components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }
        let url = components?.url
        var request = URLRequest(url: url!, cachePolicy: .reloadRevalidatingCacheData)
        request.httpMethod = route.method
        
        return request
    }
}
