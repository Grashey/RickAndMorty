//
//  TestVC.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 05.07.2024.
//

import UIKit

class TestVC: UIViewController {
    
    let items = ["Dead", "Alive", "Robot"]
    lazy var control = SegmentControl(items: items)
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        control.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(control)
        NSLayoutConstraint.activate([
            control.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            control.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        control.configure(selectedItemColor: .rm_green)
        control.configure(target: self, action: #selector(controlTapped(_:)))
        control.layer.cornerRadius = 15
    }
    
    @objc func controlTapped(_ sender: UIButton) {
        print(sender.tag)
    }
}
