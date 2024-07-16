//
//  CharacterTableViewCell.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 12.07.2024.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    private let dotSide: CGFloat = 5
    private let imageHeight: CGFloat = 156
    private let majorTextColor: UIColor = .rm_white
    private let minorTextColor: UIColor = .rm_gray
    
    // MARK: UI Elements
    private lazy var mainBackground: UIView = {
        $0.backgroundColor = .rm_background
        $0.layer.cornerRadius = UIConstants.cornerRadius
        $0.layer.masksToBounds = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var characterImageView: UIImageView = {
        $0.image = UIImage(named: "imagePlaceholder")
        $0.contentMode = .scaleAspectFill
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var nameLabel: UILabel = {
        $0.font = UIFont(name: Fonts.bold, size: UIConstants.headerFontSize)
        $0.textColor = majorTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var detailsButton: ExpandedButton = {
        $0.setImage(UIImage(named: "dropDownArrow"), for: .normal)
        $0.setImage(UIImage(named: "dropUpArrow"), for: .selected)
        $0.tintColor = .rm_dropdownArrow
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ExpandedButton())
    
    private lazy var nameStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillProportionally
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private lazy var speciesLabel: UILabel = {
        $0.font = UIFont(name: Fonts.semiBold, size: UIConstants.majorFontSize)
        $0.textColor = majorTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var statusView: UIView = {
        $0.layer.cornerRadius = dotSide/2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var statusLabel: UILabel = {
        $0.font = UIFont(name: Fonts.semiBold, size: UIConstants.majorFontSize)
        $0.textColor = majorTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var statusStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private lazy var locationLabel: UILabel = {
        $0.text = "Last known location"
        $0.font = UIFont(name: Fonts.semiBold, size: UIConstants.minorFontSize)
        $0.textColor = minorTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var locationValueLabel: UILabel = {
        $0.font = UIFont(name: Fonts.semiBold, size: UIConstants.majorFontSize)
        $0.textColor = majorTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var locationStack: UIStackView = {
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private lazy var episodeLabel: UILabel = {
        $0.text = "First seen in:"
        $0.font = UIFont(name: Fonts.semiBold, size: UIConstants.minorFontSize)
        $0.textColor = minorTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var episodeValueLabel: UILabel = {
        $0.font = UIFont(name: Fonts.semiBold, size: UIConstants.majorFontSize)
        $0.textColor = majorTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var episodeStack: UIStackView = {
        $0.axis = .vertical
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private lazy var infotextView: UITextView = {
        $0.textContainer.lineFragmentPadding = .zero
        $0.backgroundColor = .rm_background
        $0.isScrollEnabled = false
        $0.textContainer.maximumNumberOfLines = 6
        $0.textContainer.lineBreakMode = .byWordWrapping
        $0.isUserInteractionEnabled = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextView())
    
    private lazy var readMoreButton: UIButton = {
        let title = "Read more"
        let string = NSMutableAttributedString(string: title)
        let range = NSRange(location: 0, length: title.count)
        string.addAttribute(.foregroundColor, value: UIColor.rm_green, range: range)
        string.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        string.addAttribute(.underlineColor, value: UIColor.rm_green, range: range)
        string.addAttribute(.font, value: UIFont(name: Fonts.semiBold, size: UIConstants.majorFontSize) ?? .systemFont(ofSize: UIConstants.majorFontSize, weight: .semibold), range: range)
        $0.setAttributedTitle(string, for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    private lazy var dropdownView: UIView = {
        $0.isHidden = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var mainStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    // MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        addConstraints()
        contentView.backgroundColor = .rm_black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(detailsButton)
        
        statusStack.addArrangedSubview(statusView)
        statusStack.addArrangedSubview(statusLabel)
        
        locationStack.addArrangedSubview(locationLabel)
        locationStack.addArrangedSubview(locationValueLabel)
        
        episodeStack.addArrangedSubview(episodeLabel)
        episodeStack.addArrangedSubview(episodeValueLabel)
        
        dropdownView.addSubview(infotextView)
        dropdownView.addSubview(readMoreButton)
        
        mainStack.addArrangedSubview(nameStack)
        mainStack.addArrangedSubview(speciesLabel)
        mainStack.addArrangedSubview(statusStack)
        mainStack.addArrangedSubview(locationStack)
        mainStack.addArrangedSubview(episodeStack)
        mainStack.addArrangedSubview(dropdownView)
        
        mainBackground.addSubview(characterImageView)
        mainBackground.addSubview(mainStack)
        contentView.addSubview(mainBackground)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            mainBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.majorPadding/2),
            mainBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -UIConstants.majorPadding/2),
            mainBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.majorPadding),
            mainBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.majorPadding),
            
            characterImageView.heightAnchor.constraint(equalToConstant: imageHeight),
            characterImageView.topAnchor.constraint(equalTo: mainBackground.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: mainBackground.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: mainBackground.trailingAnchor),
            
            mainStack.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: UIConstants.majorPadding),
            mainStack.bottomAnchor.constraint(equalTo: mainBackground.bottomAnchor, constant: -UIConstants.majorPadding),
            mainStack.leadingAnchor.constraint(equalTo: mainBackground.leadingAnchor, constant: UIConstants.majorPadding),
            mainStack.trailingAnchor.constraint(equalTo: mainBackground.trailingAnchor, constant: -UIConstants.majorPadding),
            
            infotextView.topAnchor.constraint(equalTo: dropdownView.topAnchor),
            infotextView.leadingAnchor.constraint(equalTo: dropdownView.leadingAnchor),
            infotextView.trailingAnchor.constraint(equalTo: dropdownView.trailingAnchor),
            
            readMoreButton.topAnchor.constraint(equalTo: infotextView.bottomAnchor, constant: UIConstants.minorPadding/2),
            readMoreButton.bottomAnchor.constraint(equalTo: dropdownView.bottomAnchor),
            readMoreButton.leadingAnchor.constraint(equalTo: dropdownView.leadingAnchor),
            
            statusView.heightAnchor.constraint(equalToConstant: dotSide),
            statusView.widthAnchor.constraint(equalTo: statusView.heightAnchor)
        ])
    }
    
    // MARK: Internal methods
    func configureWith(_ model: CharacterModel, tag: Int) {
        nameLabel.text = model.name
        statusLabel.text = model.status.rawValue
        statusView.backgroundColor = model.status == .alive ? .rm_green : .rm_red
        speciesLabel.text = model.species.rawValue
        locationValueLabel.text = model.lastLocation
        episodeValueLabel.text = model.firstEpisode
        if let data = model.imageData {
            characterImageView.image = UIImage(data: data)
        }
        detailsButton.tag = tag
        readMoreButton.tag = tag
        
        let attributeString = NSMutableAttributedString(string: model.info)
        let range = NSRange(location: 0, length: model.info.count)
        let style = NSMutableParagraphStyle()
        if let font = UIFont(name: Fonts.main, size: UIConstants.majorFontSize) {
            style.lineSpacing = (font.pointSize * 1.5) - font.lineHeight
            attributeString.addAttribute(.font, value: font, range: range)
        }
        attributeString.addAttribute(.paragraphStyle, value: style, range: range)
        attributeString.addAttribute(.foregroundColor, value: UIColor.rm_white, range: range)
        infotextView.attributedText = attributeString
    }
    
    func configureActions(target: Any?, dropDown: Selector, readMore: Selector) {
        detailsButton.addTarget(target, action: dropDown, for: .touchUpInside)
        readMoreButton.addTarget(target, action: readMore, for: .touchUpInside)
    }
    
    func configureDropDown(isActive: Bool) {
        detailsButton.isSelected = isActive
        dropdownView.isHidden = !isActive
    }
    
}
