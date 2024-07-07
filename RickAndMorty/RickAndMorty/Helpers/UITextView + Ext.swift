//
//  UITextView + Ext.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 02.07.2024.
//

import UIKit

extension UITextView {
    
    func expanded() -> Self {
        if let text = text, let font = font {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = (font.pointSize * 1.5) - font.lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSRange(location: 0, length: text.count))
            self.attributedText = attributeString
        }
        return self
    }
}
