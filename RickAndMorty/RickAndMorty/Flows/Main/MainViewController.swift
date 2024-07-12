//
//  MainViewController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 12.07.2024.
//

import UIKit

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
        mainView.configureScroll(refreshControl: refreshControl)
        navigationController?.isNavigationBarHidden = true
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
