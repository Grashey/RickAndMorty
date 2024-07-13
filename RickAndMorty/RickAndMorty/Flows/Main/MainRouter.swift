//
//  MainRouter.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 13.07.2024.
//

import UIKit

class MainRouter: Router {
    
    func onCharacterDetail() {
        let controller = CharacterViewController()
        push(controller)
    }
}
