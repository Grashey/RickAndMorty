//
//  SpinnerController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 16.07.2024.
//

import UIKit

class SpinnerController: UIViewController {

    private let spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = .clear
        spinner.color = .rm_white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        spinner.startAnimating()
    }
}
