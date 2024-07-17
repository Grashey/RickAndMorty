//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 14.07.2024.
//

import Foundation

enum NetworkError: Error {
    case notFound(code: Int)
    case client(code: Int)
    case server(code: Int)
    case response
    case data
    case unknown(code: Int)

    var message: String {
        switch self {
        case .notFound(let code):
            return "\(code) not found"
        case .client(let code):
            return "\(code): client error"
        case .server(let code):
            return "\(code): server error"
        case .response:
            return "no resposne"
        case .data:
            return "data error"
        case .unknown(let code):
            return "\(code): unknown error"
        }
    }
}
