//
//  DropDownView.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 05.07.2024.
//

import UIKit

class DropDownView: UIView {
    
    // MARK: Constants
    private let paddingW: CGFloat = 17
    private let paddingH: CGFloat = 10
    private var backColor = UIColor.rm_background
    private var textColor = UIColor.rm_white
    private var textSize: CGFloat = UIConstants.textSize
    private var cornerRadius: CGFloat = UIConstants.cornerRadius
    
    // MARK: UI Elements
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
        $0.spacing = 16
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(rowSelected(_:)))
        $0.addGestureRecognizer(tapGR)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())

    // MARK: LifeCycle
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
    
    // MARK: Internal methods
    private func makeRow(value: String) -> UILabel {
        let label: UILabel = {
            $0.font = UIFont(name: Fonts.semiBold, size: textSize)
            $0.adjustsFontSizeToFitWidth = true
            $0.textColor = textColor
            $0.textAlignment = .left
            $0.text = value
            $0.translatesAutoresizingMaskIntoConstraints = false
            return $0
        }(UILabel())
        return label
    }
    
    @objc private func toggleList() {
        scrollView.contentOffset.y = .zero
        contentView.isHidden.toggle()
    }
    
    @objc private func rowSelected(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: stackView)
        let label = stackView.arrangedSubviews.first(where: {$0.frame.contains(point)}) as? UILabel
        button.configureTitle(label?.text)
        contentView.isHidden.toggle()
        button.isSelected.toggle()
    }
    
    // MARK: External Configuration
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
            stackView.addArrangedSubview(row)
        }
    }
    
    func configureWith(backColor: UIColor) {
        contentView.backgroundColor = backColor
        button.configureWith(backColor: backColor)
    }
    
    func configureWith(mainTextColor: UIColor) {
        stackView.arrangedSubviews.forEach({($0 as? UILabel)?.textColor = mainTextColor})
        button.configureWith(mainTextColor: mainTextColor)
    }
    
    func configureWith(secondaryTextColor: UIColor) {
        button.configureWith(secondaryTextColor: secondaryTextColor)
    }
    
    func configureWith(mainTextSize: CGFloat) {
        stackView.arrangedSubviews.forEach({($0 as? UILabel)?.font = UIFont(name: Fonts.semiBold, size: mainTextSize)})
        button.configureWith(mainTextSize: mainTextSize)
    }
    
    func configureWith(secondaryTextSize: CGFloat) {
        button.configureWith(secondaryTextSize: secondaryTextSize)
    }
    
    func configureWith(cornerRadius: CGFloat) {
        contentView.layer.cornerRadius = cornerRadius
        button.configureWith(cornerRadius: cornerRadius)
    }
}
