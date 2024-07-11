//
//  PaddingLabel.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 09.07.2024.
//

import UIKit

class PaddingLabel: UILabel {
    
    private var topInset: CGFloat = 0
    private var bottomInset: CGFloat = 0
    private var leftInset: CGFloat = 0
    private var rightInset: CGFloat = 0
    
    init(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) {
        self.init()
        topInset = top
        bottomInset = bottom
        leftInset = left
        rightInset = right
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override public var intrinsicContentSize: CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
}
