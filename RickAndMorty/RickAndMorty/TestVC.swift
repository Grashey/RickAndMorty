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
        view.backgroundColor = .rm_black
        navigationController?.isNavigationBarHidden = true
        
        let searchView = SearchTextField()
        searchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchView)
        
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
        
        for item in items {
            let button = RmButton()
            button.setTitle(item, for: .normal)
            button.configureColor(normal: .red, selected: .yellow)
            button.configureTitleColor(normal: .yellow, selected: .red)
            stack.addArrangedSubview(button)
        }
        
        let menu = DropDownView()
        menu.configureTitle("All")
        menu.configureHeader("Last seen in:")
        menu.configure(list: items + items + items, with: #selector(menuTapped))
        menu.configureWith(mainTextColor: .red)
        menu.configureWith(secondaryTextColor: .yellow)
        menu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menu)
        
        NSLayoutConstraint.activate([
            menu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            menu.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            menu.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 16)
        ])
        
        let contrItems = items[1...2]
        let control = SegmentControl(items: Array(contrItems))
        control.configureTextColor(selected: .red, normal: .yellow)
        control.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(control)
        
        NSLayoutConstraint.activate([
            control.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            control.bottomAnchor.constraint(equalTo: stack.topAnchor, constant: -16)
        ])
        
    }
    
    @objc func menuTapped() {}
    
}
