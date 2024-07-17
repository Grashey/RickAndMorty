//
//  CharacterPresenter.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 17.07.2024.
//

import Foundation

protocol iCharacterPresenter {
    var model: CharacterModel {get}
}

class CharacterPresenter: iCharacterPresenter {
    
    weak var viewController: CharacterViewController?
    
    let model: CharacterModel
    
    init(model: CharacterModel) {
        self.model = model
    }
}
