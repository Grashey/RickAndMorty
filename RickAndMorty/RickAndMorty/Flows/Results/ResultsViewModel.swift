//
//  ResultsViewModel.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 13.07.2024.
//

import UIKit

class ResultsViewModel: ObservableObject {
    
    @Published var results: [CharacterModel]
    
    init() {
        let character = CharacterModel(name: "Paul Van Dyke", status: .alive, species: .human, lastLocation: "London", firstEpisode: "Another side of the Moon", info: InfoBlock.text, imageData: UIImage(named: "imagePlaceholder")?.pngData() ?? Data())
        
        results = [character, character, character, character, character, character]
        results = []
    }
}
