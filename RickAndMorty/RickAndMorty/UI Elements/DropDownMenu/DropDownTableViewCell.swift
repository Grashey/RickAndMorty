//
//  DropDownTableViewCell.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 09.07.2024.
//

import UIKit

class DropDownTableViewCell: UITableViewCell {
    
    private lazy var label: PaddingLabel = {
        $0.font = UIFont(name: Fonts.semiBold, size: 12)
        $0.textColor = .rm_white
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(PaddingLabel(top: 8, bottom: 8, left: 17, right: 17))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        addSubviews()
        addConstraints()
        backgroundColor = .rm_background
        selectionStyle = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubview(label)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configureWith(_ text: String) {
        label.text = text
    }
    
}
