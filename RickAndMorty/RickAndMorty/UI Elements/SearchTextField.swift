//
//  SearchTextField.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 06.07.2024.
//

import UIKit

class SearchTextField: UISearchTextField {
    
    private let padding = UIEdgeInsets(top: 0, left: 17, bottom: 0, right: 17)
    private let imageView = UIImageView(image: UIImage(named: "magnifier"))

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont(name: Fonts.bold, size: 12)
        attributedPlaceholder = NSAttributedString(string: "Search by name", attributes: [.foregroundColor: UIColor.rm_white])
        backgroundColor = .rm_background
        tintColor = .rm_white
        returnKeyType = .search
        layer.masksToBounds = true
        layer.cornerRadius = 15
        
        leftView = nil
        imageView.contentMode = .scaleAspectFit
        rightView = imageView
        rightViewMode = .unlessEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
