//
//  ResultsViewController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 12.07.2024.
//

import UIKit

// Блок с таблицей результатов
class ResultsViewController: UITableViewController {
    
    private let viewModel = ResultsViewModel()
    // хранение открытых/закрытых ячеек
    private var expandedDict: [IndexPath : Bool] = [:]
    // закрытие всех popUp в других блоках
    var closeOthers: (() -> Void)?
    // навигация
    var onCharacterDetails: ((CharacterModel) -> Void)?
    
    override func viewDidLoad() {
        tableView = ContentSizedTableView()
        tableView.backgroundColor = .rm_black
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.description())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.description(), for: indexPath)
        (cell as? CharacterTableViewCell)?.configureWith(viewModel.results[indexPath.row], tag: indexPath.row)
        (cell as? CharacterTableViewCell)?.configureActions(target: self, dropDown: #selector(dropDownButtonTapped(_:)), readMore: #selector(readMore))
        (cell as? CharacterTableViewCell)?.configureDropDown(isActive: expandedDict[indexPath] ?? false)
        return cell
    }
    
    @objc func dropDownButtonTapped(_ sender: UIButton) {
        closeOthers?()
        let indexPath = IndexPath(row: sender.tag, section: .zero)
        if let existed = expandedDict[indexPath] {
            expandedDict[indexPath] = !existed
        } else {
            expandedDict[indexPath] = true
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    @objc func readMore(_ sender: UIButton) {
        let model = viewModel.results[sender.tag]
        onCharacterDetails?(model)
    }

}
