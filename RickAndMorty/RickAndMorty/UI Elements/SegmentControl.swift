//
//  SegmentControl.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 05.07.2024.
//

import UIKit

class SegmentControl: UIView {
    
    // MARK: Constants
    private var items: [String] = []
    private var itemsConstraints: [(NSLayoutConstraint, NSLayoutConstraint)] = []
    private var buttons: [UIButton] = []
    private var normalTextColor: UIColor = .rm_white
    private var selectedTextColor: UIColor = .rm_black
    private var selectedContentColor: UIColor = .rm_green
    
    var selectedIndex: Int = .zero
    
    private let buttonHeight: CGFloat = UIConstants.insideHeight
    private var fontSize: CGFloat = UIConstants.majorFontSize
    private let offsetW: CGFloat = 6
    private let offsetH: CGFloat = 6
    private let spacing: CGFloat = 3
        
    // MARK: UI Elements
    private lazy var contentView: UIView = {
        $0.backgroundColor = selectedContentColor
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rm_background
        self.clipsToBounds = true
        self.layer.cornerRadius = UIConstants.cornerRadius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(itemsCount: Int) {
        self.init()
        items = Array(repeating: String(), count: itemsCount)
        addSubviews()
        addConstraints()
        itemsConstraints = makeConstraintsFor(items)
        reloadConstraints()
        updateLabels()
    }
    
    override func layoutSubviews() {
        contentView.layer.cornerRadius = self.layer.cornerRadius - 4
    }
    
    // MARK: Internal methods
    private func addSubviews() {
        addSubview(contentView)
        
        for index in .zero..<items.count {
            let button: UIButton = {
                $0.tag = index
                $0.setTitle(items[index], for: .normal)
                $0.titleLabel?.font = UIFont(name: Fonts.bold, size: fontSize)
                $0.setContentCompressionResistancePriority(.required, for: .vertical)
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                return $0
            }(UIButton())
            addSubview(button)
            buttons.append(button)
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: offsetH),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -offsetH)
        ])
        
        for index in .zero..<buttons.count {
            NSLayoutConstraint.activate([
                buttons[index].widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/CGFloat(items.count)),
                buttons[index].topAnchor.constraint(equalTo: self.topAnchor, constant: offsetH),
                buttons[index].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -offsetH),
                buttons[index].heightAnchor.constraint(equalToConstant: buttonHeight)
            ])
            if index == .zero {
                NSLayoutConstraint.activate([
                    buttons[index].leadingAnchor.constraint(equalTo: self.leadingAnchor)
                ])
            } else if index == (items.count - 1) {
                NSLayoutConstraint.activate([
                    buttons[index].leadingAnchor.constraint(equalTo: buttons[index-1].trailingAnchor),
                    buttons[index].trailingAnchor.constraint(equalTo: self.trailingAnchor)
                ])
            } else {
                NSLayoutConstraint.activate([
                    buttons[index].leadingAnchor.constraint(equalTo: buttons[index-1].trailingAnchor)
                ])
            }
        }
    }
    
    private func makeConstraintsFor(_ items: [String]) -> [(NSLayoutConstraint, NSLayoutConstraint)] {
        guard !items.isEmpty else { fatalError("items are empty") }
        let devider = CGFloat(items.count)
        var constraints = Array(repeating: (NSLayoutConstraint(), NSLayoutConstraint()), count: Int(devider))
        for index in .zero..<items.count {
            guard items.count != 1 else {
                let leading = NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: offsetW)
                let trailing = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -offsetW)
                constraints[index] = (leading, trailing)
                return constraints
            }
            if index == .zero {
                let leading = NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: offsetW)
                let trailing = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1/devider, constant: -spacing)
                constraints[index] = (leading, trailing)
            } else if index == items.count - 1 {
                let leading = NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: CGFloat(index)/devider, constant: spacing)
                let trailing = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -offsetW)
                constraints[index] = (leading, trailing)
            } else {
                let leading = NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: CGFloat(index)/devider, constant: spacing)
                let trailing = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: CGFloat(index+1)/devider, constant: -spacing)
                constraints[index] = (leading, trailing)
            }
            
            let pair = constraints[index]
            pair.0.priority = UILayoutPriority(750)
            pair.1.priority = UILayoutPriority(750)
            NSLayoutConstraint.activate([pair.0, pair.1])
        }
        return constraints
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        reloadConstraints()
        updateLabels()
        UIView.animate(withDuration: 0.25, delay: .zero, options: .curveEaseOut, animations: { [unowned self] in
            self.layoutIfNeeded()
        })
    }
    
    private func reloadConstraints() {
        for index in .zero..<itemsConstraints.count {
            let pair = itemsConstraints[index]
            pair.0.priority = index == selectedIndex ? UILayoutPriority(900) : UILayoutPriority(750)
            pair.1.priority = index == selectedIndex ? UILayoutPriority(900) : UILayoutPriority(750)
        }
    }
    
    private func updateLabels() {
        for index in .zero..<buttons.count {
            buttons[index].setTitleColor(index == selectedIndex ? selectedTextColor : normalTextColor, for: .normal)
        }
    }
    
    // MARK: External Configuration
    func configure(selectedItemColor: UIColor) {
        contentView.backgroundColor = selectedItemColor
    }
    
    func configureTextColor(selected: UIColor, normal: UIColor) {
        selectedTextColor = selected
        normalTextColor = normal
        updateLabels()
    }
    
    func configure(target: Any?, action: Selector) {
        buttons.forEach { $0.addTarget(target, action: action, for: .touchUpInside)}
    }
    
    func configure(_ items: [String]) {
        guard items.count == buttons.count else { return }
        for index in .zero..<items.count {
            buttons[index].setTitle(items[index], for: .normal)
        }
    }
}
