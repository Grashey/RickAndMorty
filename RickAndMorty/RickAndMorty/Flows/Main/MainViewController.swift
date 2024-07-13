//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 12.07.2024.
//

import UIKit

// Контейнер для блоков экрана
class MainViewController: UIViewController {
    
    private lazy var mainView = MainView()
    private var refreshControl: UIRefreshControl!
    
    // MARK: Childs
    var filter: FilterViewController? = FilterViewController()
    var results: ResultsViewController? = ResultsViewController()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        addContainer(type: .filter, child: filter)
        addContainer(type: .results, child: results)
        mainView.configureScrollView(refreshControl: refreshControl)
        mainView.configureScrollView(delegate: self)
        navigationController?.isNavigationBarHidden = true
        
        results?.closeOthers = { [unowned self] in
            filter?.closeFilters()
            filter?.view.endEditing(true)
        }
        
        // при более сложной навигации нужно будет создать слой навигации
        results?.onCharacterDetails = { [unowned self] model in
            let detailVC = CharacterViewController()
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func addContainer(type: MainView.Container, child: UIViewController?) {
        guard let child = child else { return }
        addChild(child)
        mainView.configure(container: type, view: child.view)
        child.didMove(toParent: self)
    }
    
    private func removeContainer(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.removeFromParent()
        child.view.removeFromSuperview()
    }
    
    @objc private func refresh() {
        refreshControl.endRefreshing()
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        filter?.view.endEditing(true)
    }
}
