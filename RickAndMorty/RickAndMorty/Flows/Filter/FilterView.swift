//
//  FilterView.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 08.07.2024.
//

import UIKit

class FilterView: UIView {
    
    // MARK: UI Elements
    private lazy var searchField: SearchTextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(SearchTextField())
    
    private lazy var headerView: UIView = {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var segmentControl: SegmentControl = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(SegmentControl(itemsCount: 2))
    
    private lazy var buttonsStack: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.distribution = .fillEqually
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    private lazy var locationFilter: DropDownButton = {
        $0.tag = 0
        $0.configureHeader("Last known location")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(DropDownButton())
    
    private lazy var appearanceFilter: DropDownButton = {
        $0.tag = 1
        $0.configureHeader("First seen in:")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(DropDownButton())
    
    // MARK: LifeCycle
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
        addSubview(searchField)
        addSubview(headerView)
        addSubview(segmentControl)
        addSubview(buttonsStack)
        addSubview(locationFilter)
        addSubview(appearanceFilter)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.offsetW),
            searchField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.offsetW),
            
            headerView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: UIConstants.offsetH),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            segmentControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: UIConstants.offsetW),
            segmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.offsetW),
            segmentControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.offsetW),
            
            buttonsStack.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: UIConstants.offsetH),
            buttonsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.offsetW),
            buttonsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.offsetW),
            
            locationFilter.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: UIConstants.offsetH),
            locationFilter.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.offsetW),
            locationFilter.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.offsetW),
            
            appearanceFilter.topAnchor.constraint(equalTo: locationFilter.bottomAnchor, constant: UIConstants.offsetH),
            appearanceFilter.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.offsetW),
            appearanceFilter.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.offsetW)
        ])
    }
    
    // MARK: External Configuration
    func configureSearchTextField(delegate: UISearchTextFieldDelegate) {
        searchField.delegate = delegate
    }
    
    func configureSegmentControl(items: [String], action: Selector) {
        segmentControl.configure(items)
        segmentControl.configure(target: nil, action: action)
    }
    
    func configureButtons(items: [String], action: Selector) {
        items.forEach({ title in
            let button = RmButton()
            button.setTitle(title, for: .normal)
            button.addTarget(nil, action: action, for: .touchUpInside)
            buttonsStack.addArrangedSubview(button)
        })
    }
    
    func configureLocationFilter(title: String, action: Selector) {
        locationFilter.setTitle(title, for: .normal)
        locationFilter.addTarget(nil, action: #selector(isSelectedToggle(_:)), for: .touchUpInside)
        locationFilter.addTarget(nil, action: action, for: .touchUpInside)
    }
    
    func configureAppearanceFilter(title: String, action: Selector) {
        appearanceFilter.setTitle(title, for: .normal)
        appearanceFilter.addTarget(nil, action: #selector(isSelectedToggle(_:)), for: .touchUpInside)
        appearanceFilter.addTarget(nil, action: action, for: .touchUpInside)
    }
    
    func deselectFilterButtons() {
        locationFilter.isSelected = false
        appearanceFilter.isSelected = false
    }
    
    func configureHeader(view: UIView) {
        fillContainer(parentView: headerView, childView: view)
    }
        
    // MARK: Internal methods
    private func fillContainer(parentView: UIView, childView: UIView) {
        childView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(childView)
        NSLayoutConstraint.activate([
            childView.topAnchor.constraint(equalTo: parentView.topAnchor),
            childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor),
            childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor)
        ])
    }
    
    @objc private func isSelectedToggle(_ sender: UIButton) {
        sender.isSelected.toggle()
        var buttons = [locationFilter, appearanceFilter]
        buttons.remove(at: sender.tag)
        buttons.forEach({ button in
            let status = button.isSelected
            button.isSelected = sender.isSelected ? false : status
        })
    }
}
