//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 08.07.2024.
//

import UIKit

// Блок со всеми фильтрами и строкой поиска
class FilterViewController: UIViewController {
    
    var presenter: iFilterPresenter!
    
    private lazy var filterView = FilterView()
    
    //MARK: Callback
    var filterChanged: ((FilterModel) -> Void)?

    override func loadView() {
        view = filterView
    }
    
    override func viewDidLoad() {
        makeAndPlaceHeader()
        
        filterView.configureButtons(action: #selector(filterSpecies(_:)))
        filterView.configureSegmentControl(action: #selector(filterStatus(_:)))
        filterView.configureFilters(title: "All", action: #selector(showList(_:)))
        filterView.configureSearchTextField(delegate: self)
    }
    
    @objc private func filterStatus(_ sender: UIButton) {
        closeFilters()
        guard let status = Status.init(rawValue: sender.titleLabel?.text ?? "") else { return }
        presenter.filter.status = status
    }
    
    @objc private func filterSpecies(_ sender: UIButton) {
        guard let species = Species.init(rawValue: sender.titleLabel?.text ?? "") else { return }
        if presenter.filter.species != species {
            presenter.filter.species = species
        } else {
            presenter.filter.species = nil
        }
    }
    
    @objc func showList(_ sender: UIButton)  {
        hideMenu()
        if sender.isSelected {
            let width = sender.frame.size.width
            let listType: DropDownListType = sender.tag == .zero ? .location : .episode
            let listInput = DropDownInput(listType: listType)
            let list = DropDownMenuFactory.build(input: listInput)
            list.view.frame = CGRect(origin: CGPoint(x: sender.frame.minX, y: sender.frame.maxY), size: CGSize(width: width, height: UIConstants.dropdownMenuHeight))
            show(list)
            
            list.itemSelected = { [unowned self] item in
                switch listType {
                case .location: presenter.filter.location = (item == "All") ? nil : item
                case .episode: presenter.filter.appearance = (item == "All") ? nil : item
                }
                hideMenu()
                sender.isSelected.toggle()
                sender.setTitle(item, for: .normal)
            }
        }
    }
    
    private func makeAndPlaceHeader() {
        let header = HeaderViewController()
        addChild(header)
        filterView.configureHeader(view: header.view)
        header.didMove(toParent: self)
    }
    
    private func show(_ list: UIViewController) {
        self.parent?.addChild(list) // открытое меню ниже границы текущего вью, кладем в Main чтобы открытое меню имело под собой респондер родителя
        self.view.superview?.superview?.addSubview(list.view)
        list.didMove(toParent: self.parent)
    }
    
    private func hideMenu() {
        guard let listOpened = self.parent?.children.first(where: {$0 .isKind(of: DropDownMenu.self)}) else { return }
        listOpened.willMove(toParent: nil)
        listOpened.view.removeFromSuperview()
        listOpened.removeFromParent()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeFilters()
    }
    
    func closeFilters() {
        hideMenu()
        filterView.deselectFilterButtons()
    }
}

extension FilterViewController: UISearchTextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        closeFilters()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard presenter.filter.name != textField.text else { return false }
        presenter.filter.name = textField.text
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard presenter.filter.name != textField.text else { return }
        presenter.filter.name = textField.text
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        presenter.filter.name = nil
        return true
    }

}
