//
//  CharacterFactory.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 17.07.2024.
//

import Foundation

enum CharacterFactory {
    
    static func build(input: ModuleInput?) -> CharacterViewController {
        guard let input = input as? CharacterInput else { fatalError("moduleInput missed") }
        let controller = CharacterViewController()
        let presenter = CharacterPresenter(model: input.model)
        controller.presenter = presenter
        presenter.viewController = controller
        return controller
    }
}
