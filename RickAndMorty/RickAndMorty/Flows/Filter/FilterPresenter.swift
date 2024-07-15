//
//  FilterPresenter.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

protocol iFilterPresenter {
    var filter: FilterModel {get set}
}

class FilterPresenter: iFilterPresenter {
    
    weak var viewController: FilterViewController?
    
    var filter: FilterModel = FilterModel(name: nil, status: .dead, species: [], location: nil, appearance: nil) {
        didSet {
            print(filter.name)
            print(filter.status)
            print(filter.species)
            print(filter.location)
            print(filter.appearance)
        }
    }
}
