//
//  DropDownPresenter.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

protocol iDropDownPresenter {
    var items: [String] {get set}
    
    func getList()
}

class DropDownPresenter: iDropDownPresenter {
    
    weak var viewController: DropDownMenu?
    private let networkSrvice: iDropDownNetworkService
    private let listType: DropDownListType
    
    var items: [String]  = ["All"]
    private var pageDict: [Int:[String]] = [:]
    private var currentPage: Int = 1
    private var pageCount: Int?
    
    init(listType: DropDownListType, networkService: iDropDownNetworkService) {
        self.listType = listType
        self.networkSrvice = networkService
    }
    
    func getList() {
        if let pageCount = pageCount {
            guard pageCount >= currentPage else { return }
        }
        Task {
            do {
                var data: Data
                switch listType {
                case .location:
                    data = try await networkSrvice.fetchLocations(page: currentPage)
                case .episode:
                    data = try await networkSrvice.fetchEpisodes(page: currentPage)
                }
                let response = try JSONDecoder().decode(ListResponse.self, from: data)
                pageCount = response.info.pages
                let pageItems = response.results.map({$0.name})
                pageDict[currentPage] = pageItems
                items += pageItems
                await viewController?.reloadView()
                currentPage += 1
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
