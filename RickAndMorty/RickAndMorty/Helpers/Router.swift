//
//  Router.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 13.07.2024.
//

import UIKit

protocol Router {
    
    var delegate: UIViewController? {get set}
}

extension Router {
    
    func push(_ controller: UIViewController) {
        guard let delegate = delegate else { return }
        delegate.navigationController?.pushViewController(controller, animated: true)
    }
}
