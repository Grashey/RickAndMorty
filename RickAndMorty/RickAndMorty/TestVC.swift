//
//  TestVC.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 05.07.2024.
//

import UIKit

class TestVC: UIViewController{
    
    let items = ["Dead", "Alive", "Robot"]

    override func viewDidLoad() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        
        let searchView = SearchTextField()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchView)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            searchView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
}
