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
    private let router = MainRouter()
    
    // MARK: Childs
    var filter: FilterViewController?
    var results: ResultsViewController? = ResultsViewController()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        filter = FilterFactory.build()
        addContainer(type: .filter, child: filter)
        addContainer(type: .results, child: results)
        mainView.configureScrollView(refreshControl: refreshControl)
        mainView.configureScrollView(delegate: self)
        navigationController?.isNavigationBarHidden = true
        
        filter?.filterChanged = { filter in
            
        }
        
        results?.closeOthers = { [unowned self] in
            filter?.closeFilters()
            filter?.view.endEditing(true)
        }
        
        router.delegate = self
        results?.onCharacterDetails = { [unowned self] model in
            router.onCharacterDetail()
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
