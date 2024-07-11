//
//  ExpandedButton.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 11.07.2024.
//

import UIKit

class ExpandedButton: UIButton {
    
    private var expandedBounds: CGRect {
        return CGRectInset(self.bounds, -10, -10)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        CGRectContainsPoint(expandedBounds, point) ? self : nil
    }
}
