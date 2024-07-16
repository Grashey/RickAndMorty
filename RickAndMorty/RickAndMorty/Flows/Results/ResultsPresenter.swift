//
//  ResultsPresenter.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import UIKit

protocol iResultsPresenter {
    var models: [CharacterModel] {get set}
    
    func getCharacters() 
    func updateImageFor(_ index: Int)
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
    private var isLoading = false {
        didSet {
            viewController?.isLoading = isLoading
        }
    }
   
    init(networkService: iResultsNetworkService) {
        self.networkService = networkService
        NotificationCenter.default.addObserver(self, selector: #selector(reflex(_:)), name: .filterChanged, object: nil)
    }
    
    func getCharacters() {
        if let pageCount = pageCount {
            guard pageCount >= currentPage && !isLoading else { return }
        }
        isLoading = true
        Task {
            do {
                let data = try await networkService.fetchCharacters(filter: filter, page: currentPage)
                let response = try JSONDecoder().decode(CharacterListResponse.self, from: data)
                pageCount = response.info.pages
                let characters = response.results
                
                var indexes: [Int] = []
                for index in .zero..<characters.count {
                    let newIndex = index + masterArray.count
                    indexes.append(newIndex)
                }
                masterArray += characters
                models = masterArray.map{makeModelFrom($0)}
                await viewController?.addRowsAt(indexes: indexes)
                currentPage += 1
                isLoading = false
            } catch {
                await viewController?.showToast(messageFrom(error), success: false)
            }
        }
    }
    
    private func makeModelFrom(_ model: CharacterResponse) -> CharacterModel {
        CharacterModel(name: model.name, status: Status(rawValue: model.status) ?? .alive, species: Species(rawValue: model.species) ?? .alien, lastLocation: model.location.name, firstEpisode: model.episode[0], info: CharacterInfo.text, imageData: nil)
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
        refresh()
        getCharacters()
    }
    
    func updateImageFor(_ index: Int) {
        Task {
            do {
                let model = masterArray[index]
                let data = try await networkService.fetchImage(url: model.image)
                if let image = UIImage(data: data) {
                    models[index].imageData = data
                    await viewController?.reloadRowAt(index: index)
                }
            } catch {
                await viewController?.showToast(messageFrom(error), success: false)
            }
        }
    }
    
    private func messageFrom(_ error: Error) -> String {
        if let networkError = error as? NetworkError {
            return networkError.message
        } else {
            return error.localizedDescription
        }
    }
    
}
