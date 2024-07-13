//
//  CharacterView.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 13.07.2024.
//

import UIKit

class CharacterView: UIView {
        
    private let dotSide: CGFloat = 5
    private let majorTextSize: CGFloat = 12
    private let minorTextSize: CGFloat = 8
    private let majorTextColor: UIColor = .rm_white
    
    // MARK: UI Elements
    private lazy var characterImageView: UIImageView = {
        $0.image = UIImage(named: "imagePlaceholder")
        $0.contentMode = .scaleAspectFit
        $0.setContentCompressionResistancePriority(.required, for: .vertical)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var speciesLabel: UILabel = {
        $0.font = UIFont(name: Fonts.semiBold, size: majorTextSize)
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
        $0.font = UIFont(name: Fonts.semiBold, size: majorTextSize)
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
        $0.font = UIFont(name: Fonts.semiBold, size: minorTextSize)
        $0.textColor = majorTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var locationValueLabel: UILabel = {
        $0.font = UIFont(name: Fonts.semiBold, size: majorTextSize)
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
        $0.font = UIFont(name: Fonts.semiBold, size: minorTextSize)
        $0.textColor = majorTextColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private lazy var episodeValueLabel: UILabel = {
        $0.font = UIFont(name: Fonts.semiBold, size: majorTextSize)
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
        $0.backgroundColor = .rm_black
        $0.isScrollEnabled = false
        $0.textContainer.maximumNumberOfLines = .zero
        $0.textContainer.lineBreakMode = .byWordWrapping
        $0.isUserInteractionEnabled = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITextView())
    
    private lazy var mainStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addConstraints()
        backgroundColor = .rm_black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        statusStack.addArrangedSubview(statusView)
        statusStack.addArrangedSubview(statusLabel)
        
        locationStack.addArrangedSubview(locationLabel)
        locationStack.addArrangedSubview(locationValueLabel)
        
        episodeStack.addArrangedSubview(episodeLabel)
        episodeStack.addArrangedSubview(episodeValueLabel)
        
        mainStack.addArrangedSubview(speciesLabel)
        mainStack.addArrangedSubview(statusStack)
        mainStack.addArrangedSubview(locationStack)
        mainStack.addArrangedSubview(episodeStack)
        mainStack.addArrangedSubview(infotextView)
        
        addSubview(characterImageView)
        addSubview(mainStack)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            mainStack.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: UIConstants.offsetW),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.offsetW),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.offsetW),
            
            statusView.heightAnchor.constraint(equalToConstant: dotSide),
            statusView.widthAnchor.constraint(equalTo: statusView.heightAnchor)
        ])
    }
    
    // MARK: Internal methods
    func configureWith(_ model: CharacterModel) {
        statusLabel.text = model.status.rawValue
        statusView.backgroundColor = model.status == .alive ? .rm_green : .rm_red
        speciesLabel.text = model.species.rawValue
        locationValueLabel.text = model.lastLocation
        episodeValueLabel.text = model.firstEpisode
        characterImageView.image = UIImage(data: model.imageData)
        
        let attributeString = NSMutableAttributedString(string: model.info)
        let range = NSRange(location: 0, length: model.info.count)
        let style = NSMutableParagraphStyle()
        if let font = UIFont(name: Fonts.main, size: UIConstants.textSize) {
            style.lineSpacing = (font.pointSize * 1.5) - font.lineHeight
            attributeString.addAttribute(.font, value: font, range: range)
        }
        attributeString.addAttribute(.paragraphStyle, value: style, range: range)
        attributeString.addAttribute(.foregroundColor, value: UIColor.rm_white, range: range)
        infotextView.attributedText = attributeString
    }
    
}
