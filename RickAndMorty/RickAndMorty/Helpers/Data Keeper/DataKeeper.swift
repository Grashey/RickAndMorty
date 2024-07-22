//
//  DataKeeper.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 18.07.2024.
//

import Foundation

protocol DataKeeper {
    func addCharacter(id: Int, name: String, status: String, species: String, location: String, url: String)
    func updateCharacter(id: Int, imageData: Data)
    func updateCharacter(id: Int, episode: String)
    
    func addLocation(id: Int, name: String)
    func addEpisode(id: Int, name: String)
}
