//
//  MainRouter.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 13.07.2024.
//

import UIKit

class MainRouter: Router {
    
    weak var delegate: UIViewController?
    
    func onCharacterDetail(_ model: CharacterModel) {
        let input = CharacterInput(model: model)
        let controller = CharacterFactory.build(input: input)
        push(controller)
    }
}
