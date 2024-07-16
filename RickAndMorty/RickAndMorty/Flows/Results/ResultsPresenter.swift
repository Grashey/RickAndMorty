//
//  ResultsPresenter.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

protocol iResultsPresenter {
    var models: [CharacterModel] {get set}
    
    func getCharacters() 
}

class ResultsPresenter: iResultsPresenter {
    
    weak var viewController: ResultsViewController?
    private let networkService: iResultsNetworkService
    private var filter: FilterModel = FilterModel(name: nil, status: .dead, species: nil, location: nil, appearance: nil)
    
    var models: [CharacterModel] = []
    var masterArray: [CharacterResponse] = []
    var filteredArray: [CharacterResponse] = []
    
    private var currentPage: Int = 1
    private var pageCount: Int?
   
    init(networkService: iResultsNetworkService) {
        self.networkService = networkService
        NotificationCenter.default.addObserver(self, selector: #selector(reflex(_:)), name: .filterChanged, object: nil)
    }
    
    func getCharacters() {
        if let pageCount = pageCount {
            guard pageCount >= currentPage else { return }
        }
        Task {
            do {
                let data = try await networkService.fetchCharacters(filter: filter, page: currentPage)
                let response = try JSONDecoder().decode(CharacterListResponse.self, from: data)
                pageCount = response.info.pages
                let characters = response.results
                masterArray += characters
                models = masterArray.map{makeModelFrom($0)}
                await viewController?.reloadView()
                currentPage += 1
                print(masterArray.count)
            } catch {
                await viewController?.showToast(messageFrom(error), success: false)
            }
        }
    }
    
    private func makeModelFrom(_ model: CharacterResponse) -> CharacterModel {
        CharacterModel(name: model.name, status: Status(rawValue: model.status) ?? .alive, species: Species(rawValue: model.species) ?? .alien, lastLocation: model.location.name, firstEpisode: model.episode[0], info: CharacterInfo.text, imageData: nil)
    }
    
    private func messageFrom(_ error: Error) -> String {
        if let networkError = error as? NetworkError {
            return networkError.message
        } else {
            return error.localizedDescription
        }
    }
    
    private func refresh() {
        currentPage = 1
        pageCount = nil
        models = []
        masterArray = []
        filteredArray = []
        viewController?.reloadView()
    }
    
    @objc private func reflex(_ notification: NSNotification) {
        if let filter = notification.userInfo?["filter"] as? FilterModel {
            self.filter = filter
        }
        print(filter.species)
        refresh()
        getCharacters()
    }
    
}