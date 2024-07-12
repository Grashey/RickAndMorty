//
//  ResultsViewController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 12.07.2024.
//

import UIKit


class ResultsViewController: UITableViewController {
    
    let character = CharacterModel(name: "Paul Van Dyke", status: .alive, species: .human, lastLocation: "London", firstEpisode: "Another side of the Moon", info: InfoBlock.text, image: UIImage(named: "imagePlaceholder")?.pngData() ?? Data())
    
    lazy var results = [character, character, character, character, character, character]
    private var expandedDict: [IndexPath : Bool] = [:]
    
    var closeFilters: (() -> Void)?
    
    override func viewDidLoad() {
        tableView = ContentSizedTableView()
        tableView.backgroundColor = .rm_black
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.description())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.description(), for: indexPath)
        (cell as? ResultsTableViewCell)?.configureWith(results[indexPath.row], tag: indexPath.row)
        (cell as? ResultsTableViewCell)?.configureActions(target: self, dropDown: #selector(dropDownButtonTapped(_:)), readMore: #selector(readMore))
        (cell as? ResultsTableViewCell)?.configureDropDown(isActive: expandedDict[indexPath] ?? false)
        return cell
    }
    
    @objc func dropDownButtonTapped(_ sender: UIButton) {
        closeFilters?()
        let indexPath = IndexPath(row: sender.tag, section: .zero)
        if let existed = expandedDict[indexPath] {
            expandedDict[indexPath] = !existed
        } else {
            expandedDict[indexPath] = true
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    @objc func readMore() {}

}
