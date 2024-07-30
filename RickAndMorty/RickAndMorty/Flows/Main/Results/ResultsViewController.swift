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
    private var router: MainRouter
    
    private let spinner = SpinnerController()
    var isLoading = false {
        didSet {
            guard oldValue != isLoading else { return }
            showSpinner(isShown: isLoading)
        }
    }
    
    // MARK: Child
    var filter: FilterViewController!
        
    init(router: MainRouter) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        router.delegate = self
        
        filter = FilterFactory.build()
        addChild(filter)
        filter?.didMove(toParent: self)
        
        tableView.bounces = false
        tableView.backgroundColor = .rm_black
        tableView.separatorStyle = .none
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.description())
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: FilterTableViewCell.description())
        presenter.getCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let frame = self.parent?.view.frame {
            spinner.view.frame = frame
        }
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1: return presenter.models.count
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.description(), for: indexPath)
            (cell as? CharacterTableViewCell)?.configureWith(presenter.models[indexPath.row], tag: indexPath.row)
            (cell as? CharacterTableViewCell)?.configureActions(target: self, dropDown: #selector(dropDownButtonTapped(_:)), readMore: #selector(readMore))
            (cell as? CharacterTableViewCell)?.configureDropDown(isActive: presenter.expandedDict[indexPath] ?? false)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.description(), for: indexPath)
            (cell as? FilterTableViewCell)?.configure(filter.view)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else { return }
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
        filter.closeFilters()
        let indexPath = IndexPath(row: sender.tag, section: 1)
        if let existed = presenter.expandedDict[indexPath] {
            presenter.expandedDict[indexPath] = !existed
        } else {
            presenter.expandedDict[indexPath] = true
        }
        reloadView()
    }
    
    @objc private func readMore(_ sender: UIButton) {
        let model = presenter.models[sender.tag]
        router.onCharacterDetail(model)
    }
    
    func reloadView() {
        let segmentControlAnimationTime: CGFloat = 0.25
        DispatchQueue.main.asyncAfter(deadline: .now() + segmentControlAnimationTime) { [unowned self] in
            tableView.reloadData()
        }
    }
    
    func reloadRowAt(index: Int) {
        tableView.reloadRows(at: [IndexPath(row: index, section: 1)], with: .none)
    }
    
}
