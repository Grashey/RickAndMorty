//
//  DropDownButton.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 05.07.2024.
//

import UIKit

class DropDownButton: UIButton {
    
    private let paddingH: CGFloat = 10
    private let paddingW: CGFloat = 17
    private var selectedImage = UIImage(named: "dropUpArrow")
    private var normalImage = UIImage(named: "dropDownArrow")
    private var backColor = UIColor.rm_dropdownArrow
    private var mainTextColor = UIColor.rm_green
    private var secondaryTextColor = UIColor.rm_white
    private var mainTextSize: CGFloat = 12
    private var secondaryTextSize: CGFloat = 8
    private var cornerRadius: CGFloat = 15
    
    private lazy var headerLabel: UILabel = {
        $0.font = UIFont(name: Fonts.semiBold, size: secondaryTextSize)
        $0.textColor = secondaryTextColor
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var valueLabel: UILabel = {
        $0.text = " "
        $0.font = UIFont(name: Fonts.semiBold, size: mainTextSize)
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = mainTextColor
        $0.textAlignment = .left
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var iconView: UIImageView = {
        $0.tintColor = .rm_dropdownArrow
        $0.image = normalImage
        $0.contentMode = .scaleAspectFit
        $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addConstraints()
        
        layer.cornerRadius = cornerRadius
        backgroundColor = backColor
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            iconView.image = isSelected ? selectedImage : normalImage
            layer.maskedCorners =  isSelected ? [.layerMaxXMinYCorner, .layerMinXMinYCorner] : [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard bounds.contains(point) else { return super.hitTest(point, with: event) }
        return self
    }
    
    @objc private func buttonTapped() {
        isSelected.toggle()
    }
    
    private func addSubviews() {
        contentView.addSubview(headerLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(iconView)
        addSubview(contentView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: paddingH),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -paddingH),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: paddingW),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -paddingW),
            
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
            iconView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configureHeader(_ text: String?) {
        headerLabel.text = text
    }
    
    func configureTitle(_ text: String?) {
        valueLabel.text = text
    }
    
    func configureWith(backColor: UIColor) {
        self.backColor = backColor
    }
    
    func configureWith(mainTextColor: UIColor) {
        self.mainTextColor = mainTextColor
    }
    
    func configureWith(secondaryTextColor: UIColor) {
        self.secondaryTextColor = secondaryTextColor
    }
    
    func configureWith(mainTextSize: CGFloat) {
        self.mainTextSize = mainTextSize
    }
    
    func configureWith(secondaryTextSize: CGFloat) {
        self.secondaryTextSize = secondaryTextSize
    }
    
    func configureWith(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
    }
}
