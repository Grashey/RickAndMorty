//
//  FilterViewController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 08.07.2024.
//

import UIKit

class FilterViewController: UIViewController {
    
    private lazy var filterView = FilterView()

    override func loadView() {
        view = filterView
    }
    
    let listOfLocations = ["All", "Moscow", "London", "Paris", "New-York", "Rome", "Stanbul", "Tokyo"]
    let listOfAppearance = ["All", "Episode1", "Episode2", "Episode3", "Episode4", "Episode5", "Episode6", "Episode7"]
    
    override func viewDidLoad() {
        navigationController?.isNavigationBarHidden = true
        makeAndPlaceHeader()
        
        let buttonTitles = [Species.alien.rawValue, Species.human.rawValue, Species.robot.rawValue]
        filterView.configureButtons(items: buttonTitles, action: #selector(filter))
        
        let segmentTitles = [Status.dead.rawValue, Status.alive.rawValue]
        filterView.configureSegmentControl(items: segmentTitles, action: #selector(filter))
        
        filterView.configureLocationFilter(title: listOfLocations[0], action: #selector(showList))
        filterView.configureAppearanceFilter(title: listOfAppearance[0], action: #selector(showList))
        filterView.configureSearchTextField(delegate: self)
    }
    
    
    @objc func filter() {
        closeFilters()
        view.endEditing(true)
    }
    
    @objc func showList(_ sender: UIButton)  {
        view.endEditing(true)
        hideMenu()
        if sender.isSelected {
            let width = sender.frame.size.width
            let items = sender.tag == .zero ? listOfLocations : listOfAppearance
            let list = DropDownViewController(items: items)
            list.view.frame = CGRect(origin: CGPoint(x: sender.frame.minX, y: sender.frame.maxY), size: CGSize(width: width, height: 150))
            show(list)
            
            list.itemSelected = { [unowned self] item in
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
        self.addChild(list)
        self.view.addSubview(list.view)
        list.didMove(toParent: self)
    }
    
    private func hideMenu() {
        guard let listOpened = self.children.first(where: {$0 .isKind(of: DropDownViewController.self)}) else { return }
        listOpened.willMove(toParent: nil)
        listOpened.view.removeFromSuperview()
        listOpened.removeFromParent()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeFilters()
        view.endEditing(true)
    }
    
    private func closeFilters() {
        hideMenu()
        filterView.deselectFilterButtons()
    }
}

extension FilterViewController: UISearchTextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        closeFilters()
    }
    
}