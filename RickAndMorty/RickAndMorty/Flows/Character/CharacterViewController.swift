//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 13.07.2024.
//

import UIKit

class CharacterViewController: UIViewController {
    
    private let viewModel = CharacterViewModel()
    private lazy var characterView = CharacterView()
    
    override func loadView() {
        view = characterView
    }
    
    override func viewDidLoad() {
        navigationController?.navigationBar.tintColor = .rm_green
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont(name: Fonts.bold, size: 24) ?? .systemFont(ofSize: 24, weight: .bold),
                                                                   .foregroundColor: UIColor.rm_white]
        title = viewModel.model.name
        characterView.configureWith(viewModel.model)
    }
    
}
