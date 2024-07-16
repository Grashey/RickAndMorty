//
//  Notification.Name + Ext.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import Foundation

extension Notification.Name {
    static var filterChanged: Notification.Name {
        return .init(rawValue: "filterChanged")
    }
    
    static var contentHeightChanged: Notification.Name {
        return .init(rawValue: "contentHeightChanged")
    }
}
