//
//  RmButton.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 08.07.2024.
//

import UIKit

class RmButton: UIButton {
    
    private let selectedColor: UIColor = .rm_green
    private let deselectedColor: UIColor = .rm_background
    private let selectedTitleColor: UIColor = .rm_black
    private let deselectedTitleColor: UIColor = .rm_white
    private let font = UIFont(name: Fonts.bold, size: UIConstants.textSize)
    private let height: CGFloat = UIConstants.insideHeight
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: .leastNormalMagnitude, height: height)
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? selectedColor : deselectedColor
        }
    }
    
    private func configure() {
        self.layer.cornerRadius = 10
        self.setTitleColor(deselectedTitleColor, for: .normal)
        self.setTitleColor(selectedTitleColor, for: .selected)
        self.setTitleColor(isSelected ? deselectedTitleColor : selectedTitleColor, for: .highlighted)
        self.titleLabel?.font = font
        self.isSelected = false
    }
    
    @objc private func buttonTapped() {
        isSelected.toggle()
    }
}
