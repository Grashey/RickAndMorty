//
//  FilterTableViewCell.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 17.07.2024.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(childView)
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: contentView.topAnchor),
            childView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            childView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
