//
//  DropDownView.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 05.07.2024.
//

import UIKit

class DropDownView: UIView {
    
    private let paddingW: CGFloat = 17
    private let paddingH: CGFloat = 10
    private var backColor = UIColor.rm_dropdownArrow
    private var textColor = UIColor.rm_white
    private var textSize: CGFloat = 12
    private var cornerRadius: CGFloat = 15
    
    private lazy var button: DropDownButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(toggleList), for: .touchUpInside)
        return $0
    }(DropDownButton())
    
    private lazy var contentView: UIView = {
        $0.isHidden = true
        $0.backgroundColor = backColor
        $0.layer.cornerRadius = cornerRadius
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var stackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        scrollView.addSubview(stackView)
        contentView.addSubview(scrollView)
        addSubview(button)
        addSubview(contentView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: button.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 150),
            
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -paddingH),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: paddingW),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -paddingW)
        ])
    }
    
    func configureHeader(_ text: String?) {
        button.configureHeader(text)
    }
    
    func configureTitle(_ text: String?) {
        button.configureTitle(text)
    }
    
    func configure(list: [String], with action: Selector) {
        for index in .zero..<list.count {
            let row = makeRow(value: list[index])
            row.tag = index
            row.addTarget(nil, action: action, for: .touchUpInside)
            stackView.addArrangedSubview(row)
        }
    }
    
    func configureWith(backColor: UIColor) {
        self.backColor = backColor
        button.configureWith(backColor: backColor)
    }
    
    func configureWith(mainTextColor: UIColor) {
        textColor = mainTextColor
        button.configureWith(mainTextColor: mainTextColor)
    }
    
    func configureWith(secondaryTextColor: UIColor) {
        button.configureWith(secondaryTextColor: secondaryTextColor)
    }
    
    func configureWith(mainTextSize: CGFloat) {
        textSize = mainTextSize
        button.configureWith(mainTextSize: mainTextSize)
    }
    
    func configureWith(secondaryTextSize: CGFloat) {
        button.configureWith(secondaryTextSize: secondaryTextSize)
    }
    
    func configureWith(cornerRadius: CGFloat) {
        self.cornerRadius = cornerRadius
        button.configureWith(cornerRadius: cornerRadius)
    }
    
    private func makeRow(value: String) -> UIButton {
        let button: UIButton = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentHorizontalAlignment = .leading
            $0.titleLabel?.font = UIFont(name: Fonts.semiBold, size: textSize)
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.textColor = textColor
            $0.titleLabel?.textAlignment = .left
            $0.setTitle(value, for: .normal)
            $0.addTarget(self, action: #selector(rowSelected(_:)), for: .touchUpInside)
            return $0
        }(UIButton())
        return button
    }
    
    @objc private func toggleList() {
        scrollView.contentOffset.y = .zero
        contentView.isHidden.toggle()
    }
    
    @objc private func rowSelected(_ sender: UIButton) {
        button.configureTitle(sender.titleLabel?.text)
        contentView.isHidden.toggle()
        button.isSelected.toggle()
    }
    
}
