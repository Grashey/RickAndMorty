//
//  HeaderView.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 10.07.2024.
//

import UIKit

class HeaderView: UIView {
        
    // MARK: UI Elements
    private lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private lazy var leftButton: ExpandedButton = {
        $0.setImage(UIImage(named: "arrowLeft"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ExpandedButton())
    
    private lazy var rightButton: ExpandedButton = {
        $0.setImage(UIImage(named: "arrowRight"), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ExpandedButton())
        
    private lazy var swipeLeftGR: UISwipeGestureRecognizer = {
        $0.direction = .left
        return $0
    }(UISwipeGestureRecognizer())
    
    private lazy var swipeRightGR: UISwipeGestureRecognizer = {
        $0.direction = .right
        return $0
    }(UISwipeGestureRecognizer())
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addConstraints()
        self.addGestureRecognizer(swipeLeftGR)
        self.addGestureRecognizer(swipeRightGR)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(leftButton)
        addSubview(rightButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            leftButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            leftButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.offsetW),
            
            rightButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.offsetW)
        ])
    }
    
    // MARK: External Configuration
    func configureGestures(target: Any, tapLeft: Selector, tapRight: Selector, swipe: Selector) {
        leftButton.addTarget(target, action: tapLeft, for: .touchUpInside)
        rightButton.addTarget(target, action: tapRight, for: .touchUpInside)
        swipeLeftGR.addTarget(target, action: swipe)
        swipeRightGR.addTarget(target, action: swipe)
    }
     
    func configure(image: UIImage?) {
        imageView.image = image
    }
    
}
