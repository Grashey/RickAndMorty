//
//  UIViewController + Ext.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 15.07.2024.
//

import UIKit

extension UIViewController {
    
    func showToast(_ message : String, success: Bool) {
        let backgroundColor: UIColor = success ? .rm_green :  .rm_red
        let label = UILabel(frame: CGRect(x: 30, y: view.frame.size.height - 150, width: view.frame.size.width - 60, height: 35))
        label.backgroundColor = backgroundColor.withAlphaComponent(0.7)
        label.textColor = .rm_white
        label.font = UIFont(name: Fonts.main, size: UIConstants.majorFontSize)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center;
        label.text = message
        label.alpha = 1.0
        label.layer.cornerRadius = 10;
        label.clipsToBounds  =  true
        label.numberOfLines = 1
        view.addSubview(label)
        UIView.animate(withDuration: 1.0, delay: 1, options: .curveEaseOut, animations: {
            label.transform = CGAffineTransform(translationX: 0, y: 150)
        }, completion: {(isCompleted) in
            label.removeFromSuperview()
        })
    }
}
