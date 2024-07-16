//
//  FilterFactory.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

enum FilterFactory {
    
    static func build() -> FilterViewController {
        let controller = FilterViewController()
        let presenter = FilterPresenter()
        controller.presenter = presenter
        presenter.viewController = controller
        return controller
    }
}
