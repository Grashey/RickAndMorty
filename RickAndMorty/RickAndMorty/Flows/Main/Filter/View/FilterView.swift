//
//  FilterView.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 08.07.2024.
//

import UIKit

class FilterView: UIView {
    
    private let speciesTitles = [Species.alien.rawValue, Species.human.rawValue, Species.robot.rawValue]
    private let statusTitles = [Status.dead.rawValue, Status.alive.rawValue]
    
    // MARK: UI Elements
    private lazy var searchField: SearchTextField = {
        $0.autocorrectionType = .no
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(SearchTextField())
    
    private lazy var headerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var segmentControl: SegmentControl = {
        $0.configure(statusTitles)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(SegmentControl(itemsCount: statusTitles.count))
    
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
        
        for index in .zero..<speciesTitles.count {
            let button = RmButton()
            button.tag = index
            button.setTitle(speciesTitles[index], for: .normal)
            button.addTarget(self, action: #selector(isSelectedToggle(_:)), for: .touchUpInside)
            buttonsStack.addArrangedSubview(button)
        }
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
            searchField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.majorPadding),
            searchField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.majorPadding),
            
            headerView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: UIConstants.minorPadding),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            segmentControl.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: UIConstants.majorPadding),
            segmentControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.majorPadding),
            segmentControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.majorPadding),
            
            buttonsStack.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: UIConstants.minorPadding),
            buttonsStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.majorPadding),
            buttonsStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.majorPadding),
            
            locationFilter.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: UIConstants.minorPadding),
            locationFilter.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.majorPadding),
            locationFilter.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.majorPadding),
            
            appearanceFilter.topAnchor.constraint(equalTo: locationFilter.bottomAnchor, constant: UIConstants.minorPadding),
            appearanceFilter.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -UIConstants.majorPadding),
            appearanceFilter.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: UIConstants.majorPadding),
            appearanceFilter.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -UIConstants.majorPadding)
        ])
    }
    
    // MARK: External Configuration
    func configureSearchTextField(delegate: UISearchTextFieldDelegate) {
        searchField.delegate = delegate
    }
    
    func configureSegmentControl(action: Selector) {
        segmentControl.configure(target: nil, action: action)
    }
    
    func configureButtons(action: Selector) {
        buttonsStack.arrangedSubviews.forEach({ ($0 as? UIButton)?.addTarget(nil, action: action, for: .touchUpInside)})
    }
    
    func configureFilters(title: String, action: Selector) {
        locationFilter.setTitle(title, for: .normal)
        locationFilter.addTarget(nil, action: #selector(isSelectedToggle(_:)), for: .touchUpInside)
        locationFilter.addTarget(nil, action: action, for: .touchUpInside)
        
        appearanceFilter.setTitle(title, for: .normal)
        appearanceFilter.addTarget(nil, action: #selector(isSelectedToggle(_:)), for: .touchUpInside)
        appearanceFilter.addTarget(nil, action: action, for: .touchUpInside)
    }
    
    func deselectFilterButtons() {
        locationFilter.isSelected = false
        appearanceFilter.isSelected = false
    }
    
    func configureHeader(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: headerView.topAnchor),
            view.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        ])
    }
        
    // MARK: Internal methods
    @objc private func isSelectedToggle(_ sender: UIButton) {
        let dropDownButtons: [UIButton] = [locationFilter, appearanceFilter]
        let speciesButtons = buttonsStack.arrangedSubviews.map{$0 as! UIButton}
        var buttons: [UIButton]
        
        if dropDownButtons.contains(sender) {
            buttons = dropDownButtons
        } else if speciesButtons.contains(sender) {
            buttons = speciesButtons
        } else {
            return
        }
        
        sender.isSelected.toggle()
        buttons.remove(at: sender.tag)
        buttons.forEach({ button in
            let status = button.isSelected
            button.isSelected = sender.isSelected ? false : status
        })
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !searchField.bounds.contains(point) {
            self.endEditing(true)
        }
       return super.hitTest(point, with: event)
    }
    
}
