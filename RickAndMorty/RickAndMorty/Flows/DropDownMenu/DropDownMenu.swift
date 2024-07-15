//
//  DropDownMenu.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 09.07.2024.
//

import UIKit

class DropDownMenu: UITableViewController {
    
    var presenter: iDropDownPresenter!
    
    // MARK: Callback
    var itemSelected: ((String) -> Void)?
    
    override func viewDidLoad() {
        tableView.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.description())
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = .rm_background
        view.layer.cornerRadius = UIConstants.cornerRadius
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        tableView.layer.masksToBounds = true
        
        presenter.getList()
    }
    
    func reloadView() {
        tableView.reloadData()
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.description(), for: indexPath)
        (cell as? DropDownTableViewCell)?.configureWith(presenter.items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSelected?(presenter.items[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > presenter.items.count - 2 {
            presenter.getList()
        }
    }
}
