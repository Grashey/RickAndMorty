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
    
    private let spinner = SpinnerController()
    var isLoading = false {
        didSet {
            guard oldValue != isLoading else { return }
            showSpinner(isShown: isLoading)
        }
    }
    
    override func viewDidLoad() {
        tableView = ContentSizedTableView()
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .rm_black
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.description())
        presenter.getCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let frame = self.parent?.view.frame {
            spinner.view.frame = frame
        }
    }

    private func showSpinner(isShown: Bool) {
        DispatchQueue.main.async { [unowned self] in
            if isShown {
                parent?.addChild(spinner)
                parent?.view.addSubview(spinner.view)
                spinner.didMove(toParent: parent)
            } else {
                spinner.willMove(toParent: nil)
                spinner.view.removeFromSuperview()
                spinner.removeFromParent()
            }
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
        let model = presenter?.models[indexPath.row]
        if model?.imageData == nil {
            presenter.updateModelAt(indexPath.row)
        }
    }
    
    func getResults() {
        presenter.getCharacters()
    }
    
    @objc private func dropDownButtonTapped(_ sender: UIButton) {
        closeOthers?()
        let indexPath = IndexPath(row: sender.tag, section: .zero)
        if let existed = expandedDict[indexPath] {
            expandedDict[indexPath] = !existed
        } else {
            expandedDict[indexPath] = true
        }
        reloadRowAt(index: sender.tag)
    }
    
    @objc private func readMore(_ sender: UIButton) {
        let model = presenter.models[sender.tag]
        onCharacterDetails?(model)
    }
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func addRowsAt(indexes: [Int]) {
        let indexPaths = indexes.map({IndexPath(row: $0, section: .zero)})
        tableView.insertRows(at: indexPaths, with: .none)
    }
    
    func reloadRowAt(index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: .zero)], with: .none)
    }

}
