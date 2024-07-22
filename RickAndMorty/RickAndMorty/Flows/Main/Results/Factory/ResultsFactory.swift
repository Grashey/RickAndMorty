//
//  ResultsFactory.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

enum ResultsFactory {
    
    static func build() -> ResultsViewController {
        let router = MainRouter()
        let controller = ResultsViewController(router: router)
        let httpClient = HTTPClient()
        let requestBuilder = RequestBuilder()
        let networkService = ResultsNetworkService(httpClient: httpClient, requestBuilder: requestBuilder)
        let presenter = ResultsPresenter(networkService: networkService)
        controller.presenter = presenter
        presenter.viewController = controller
        return controller
    }
}
