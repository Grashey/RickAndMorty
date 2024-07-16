//
//  DropDownMenuFactory.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

enum DropDownMenuFactory {
    
    static func build(input: ModuleInput?) -> DropDownMenu {
        guard let input = input as? DropDownInput else { fatalError("moduleInput missed") }
        let controller = DropDownMenu()
        let httpClient = HTTPClient()
        let requestBuilder = RequestBuilder()
        let networkService = DropDownNetworkService(httpClient: httpClient, requestBuilder: requestBuilder)
        let presenter = DropDownPresenter(listType: input.listType, networkService: networkService)
        controller.presenter = presenter
        presenter.viewController = controller
        return controller
    }
}
