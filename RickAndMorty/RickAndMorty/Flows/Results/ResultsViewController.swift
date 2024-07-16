//
//  ResultsViewController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 12.07.2024.
//

import UIKit

// Блок с таблицей результатов
class ResultsViewController: UITableViewController {
    
    var presenter: iResultsPresenter!
    
    // хранение открытых/закрытых ячеек
    private var expandedDict: [IndexPath : Bool] = [:]
    // закрытие всех popUp в других блоках
    var closeOthers: (() -> Void)?
    // навигация
    var onCharacterDetails: ((CharacterModel) -> Void)?
    
    override func viewDidLoad() {
        tableView.backgroundColor = .rm_black
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.description())
        presenter.getCharacters()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        if let height = self.parent?.view.frame.height {
            tableView.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.description(), for: indexPath)
        (cell as? CharacterTableViewCell)?.configureWith(presenter.models[indexPath.row], tag: indexPath.row)
        (cell as? CharacterTableViewCell)?.configureActions(target: self, dropDown: #selector(dropDownButtonTapped(_:)), readMore: #selector(readMore))
        (cell as? CharacterTableViewCell)?.configureDropDown(isActive: expandedDict[indexPath] ?? false)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > presenter.models.count - 2 {
            presenter.getCharacters()
        }
    }
    
    @objc private func dropDownButtonTapped(_ sender: UIButton) {
        closeOthers?()
        let indexPath = IndexPath(row: sender.tag, section: .zero)
        if let existed = expandedDict[indexPath] {
            expandedDict[indexPath] = !existed
        } else {
            expandedDict[indexPath] = true
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    @objc private func readMore(_ sender: UIButton) {
        let model = presenter.models[sender.tag]
        onCharacterDetails?(model)
    }
    
    func reloadView() {
        tableView.reloadData()
    }

}
