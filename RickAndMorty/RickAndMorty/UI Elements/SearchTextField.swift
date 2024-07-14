//
//  SearchTextField.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 06.07.2024.
//

import UIKit

class SearchTextField: UISearchTextField {
    
    private var mainColor: UIColor = .rm_white
    
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
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: CGFloat.leastNormalMagnitude, height: UIConstants.offsideHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont(name: Fonts.bold, size: UIConstants.majorFontSize)
        textColor = mainColor
        attributedPlaceholder = NSAttributedString(string: "Search by name", attributes: [.foregroundColor: mainColor])
        backgroundColor = .rm_black
        tintColor = mainColor
        returnKeyType = .search
        layer.masksToBounds = true
        layer.cornerRadius = UIConstants.cornerRadius
        
        leftView = nil
        imageView.contentMode = .scaleAspectFit
        rightView = imageView
        rightViewMode = .unlessEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
