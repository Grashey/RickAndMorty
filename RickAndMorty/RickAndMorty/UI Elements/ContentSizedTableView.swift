//
//  ContentSizedTableView.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 12.07.2024.
//

import UIKit

class ContentSizedTableView: UITableView {
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        // dropdownMenu на фрейме а его родитель на констрейнтах и нужно обеспечить минимальный размер вью позади меню, чтобы был респондер.
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height == .zero ? UIConstants.dropdownMenuHeight : contentSize.height)
    }
}
