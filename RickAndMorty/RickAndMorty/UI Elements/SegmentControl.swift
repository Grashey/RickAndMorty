//
//  SegmentControl.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 05.07.2024.
//

import UIKit

class SegmentControl: UIView {
    
    // MARK: Constants
    // objects
    private var items: [String] = []
    private var itemsConstraints: [(NSLayoutConstraint, NSLayoutConstraint)] = []
    private var buttons: [UIButton] = []
    
    var selectedIndex: Int = .zero
    
    // size
    private let defaultHeight: CGFloat = 42
    private var fontSize: CGFloat = 12
    
    //insets
    private let offset: CGFloat = 10
    private let spacing: CGFloat = 3
        
    // MARK: UI Elements
    private lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .rm_background
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(items: [String]) {
        self.init()
        self.items = items
        
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
                $0.titleLabel?.font = UIFont(name: Fonts.semiBold, size: 12)
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
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: offset),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -offset)
        ])
        
        for index in .zero..<buttons.count {
            NSLayoutConstraint.activate([
                buttons[index].widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/CGFloat(items.count)),
                buttons[index].topAnchor.constraint(equalTo: self.topAnchor, constant: offset),
                buttons[index].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -offset),
                buttons[index].heightAnchor.constraint(equalToConstant: 32)
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
                let leading = NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: offset)
                let trailing = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -offset)
                constraints[index] = (leading, trailing)
                return constraints
            }
            if index == .zero {
                let leading = NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: offset)
                let trailing = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1/devider, constant: -spacing)
                constraints[index] = (leading, trailing)
            } else if index == items.count - 1 {
                let leading = NSLayoutConstraint(item: contentView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: CGFloat(index)/devider, constant: spacing)
                let trailing = NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -offset)
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
        UIView.animate(withDuration: 0.25, delay: .zero, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        })
    }
    
    private func reloadConstraints() {
        for index in .zero..<itemsConstraints.count {
            if index == selectedIndex {
                let activatedPair = itemsConstraints[index]
                activatedPair.0.priority = UILayoutPriority(900)
                activatedPair.1.priority = UILayoutPriority(900)
            } else {
                let pair = itemsConstraints[index]
                pair.0.priority = UILayoutPriority(750)
                pair.1.priority = UILayoutPriority(750)
            }
        }
    }
    
    private func updateLabels() {
        for index in .zero..<buttons.count {
            buttons[index].setTitleColor(index == selectedIndex ? .rm_black : .rm_white, for: .normal)
        }
    }
    
    // MARK: External Configuration
    func configure(selectedItemColor: UIColor) {
        self.contentView.backgroundColor = selectedItemColor
    }
    
    func configure(textColor: UIColor) {
        buttons.forEach { $0.setTitleColor(textColor, for: .normal) }
    }
    
    func configure(target: Any?, action: Selector) {
        buttons.forEach { $0.addTarget(target, action: action, for: .touchUpInside)}
    }
    
}
