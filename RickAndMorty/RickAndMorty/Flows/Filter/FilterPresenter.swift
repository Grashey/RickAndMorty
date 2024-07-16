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
    
    var filter: FilterModel = FilterModel(name: nil, status: .dead, species: nil, location: nil, appearance: nil) {
        didSet {
            print("filter changed")
            viewController?.filterChanged?(filter)
            NotificationCenter.default.post(name: .filterChanged, object: nil, userInfo: ["filter":filter])
        }
    }
}
