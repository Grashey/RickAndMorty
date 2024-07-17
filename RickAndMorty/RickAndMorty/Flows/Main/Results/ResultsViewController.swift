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
        
        tableView.bounces = false
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
        filterHeight = parent?.children.first?.view.frame.height ?? .zero
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
        (cell as? CharacterTableViewCell)?.configureDropDown(isActive: presenter.expandedDict[indexPath] ?? false)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > presenter.models.count - 2 {
            presenter.getCharacters()
        }
        
        let index = min(indexPath.row + 1, presenter.models.count - 1)
        let model = presenter.models[index]
        if model.imageData == nil {
            presenter.updateModelAt(index)
        }
        
        if index == 1 {
            let modelZero = presenter.models[.zero]
            if modelZero.imageData == nil {
                presenter.updateModelAt(.zero)
            }
        }
    }
    
    @objc private func dropDownButtonTapped(_ sender: UIButton) {
        closeOthers?()
        let indexPath = IndexPath(row: sender.tag, section: .zero)
        if let existed = presenter.expandedDict[indexPath] {
            presenter.expandedDict[indexPath] = !existed
        } else {
            presenter.expandedDict[indexPath] = true
        }
        reloadView()
    }
    
    @objc private func readMore(_ sender: UIButton) {
        let model = presenter.models[sender.tag]
        onCharacterDetails?(model)
    }
    
    func reloadView() {
        tableView.reloadData()
    }
    
    func reloadRowAt(index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: .zero)], with: .none)
    }
    
    var filterHeight: CGFloat = 0
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let filterView = parent?.children.first?.view else { return }
        if scrollView.bounds.contains(filterView.bounds) {
            tableView.isScrollEnabled = false
        } else {
            tableView.isScrollEnabled = true
        }
        if scrollView == tableView {
            tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
        }
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentOffset = scrollView.contentOffset.y
        let targetOffset = CGFloat(targetContentOffset.pointee.y)
        print(currentOffset, targetOffset)
    }

}
