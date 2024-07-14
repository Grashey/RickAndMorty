//
//  DropDownMenu.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 09.07.2024.
//

import UIKit

class DropDownMenu: UITableViewController {
    
    private var items: [String] = []
    
    // MARK: Callback
    var itemSelected: ((String) -> Void)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init(items: [String]) {
        self.init(nibName: nil, bundle: nil)
        self.items = items
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.description())
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = .rm_background
        view.layer.cornerRadius = UIConstants.cornerRadius
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        tableView.layer.masksToBounds = true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.description(), for: indexPath)
        (cell as? DropDownTableViewCell)?.configureWith(items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSelected?(items[indexPath.row])
    }
    
}
