//
//  HeaderViewController.swift
//  RickAndMorty
//
//  Created by Aleksandr Fetisov on 10.07.2024.
//

import UIKit

class HeaderViewController: UIViewController {

    private lazy var headerView = HeaderView()
    private let images: [UIImage?] = [UIImage(named: "header_1"), UIImage(named: "header_2"), UIImage(named: "header_3")]
    private var imageIndex: Int = .zero
    private var animationInProgress: Bool = false
    
    override func loadView() {
        view = headerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.configure(image: images[imageIndex])
        headerView.configureGestures(target: self, tapLeft: #selector(moveRight), tapRight: #selector(moveLeft), swipe: #selector(swipe(_:)))
    }
    
    @objc private func moveLeft() {
        view.superview?.superview?.endEditing(true) // иерархия: filterView/container/headerView
        makeAnimation(toLeft: true)
    }
    
    @objc func moveRight() {
        view.superview?.superview?.endEditing(true)
        makeAnimation(toLeft: false)
    }
    
    private func makeAnimation(toLeft: Bool) {
        guard !animationInProgress else { return }
        let sign: CGFloat = toLeft ? 1 : -1  // определитель с какой стороны поедет картинка
        let currentIndex = imageIndex
        
        // крутим индексы по кругу влево или вправо
        if toLeft {
            imageIndex = (imageIndex == .zero) ? (images.count - 1) : (imageIndex - 1)
        } else {
            imageIndex = (imageIndex == images.count - 1) ? (.zero) : (imageIndex + 1)
        }
        
        let arriving = makeViewWith(imageIndex)
        let leaving = makeViewWith(currentIndex)
        arriving.transform = CGAffineTransform(translationX: (headerView.frame.size.width)*sign , y: .zero) // начальная позиция за пределами окна
        
        UIView.animate(withDuration: 0.5, animations: { [unowned self] in
            animationInProgress = true
            arriving.transform = .identity
            leaving.transform = CGAffineTransform(translationX: (headerView.frame.size.width)*(-sign), y: .zero)
        }, completion: { [unowned self] _ in
            headerView.configure(image: images[imageIndex])
            arriving.removeFromSuperview()
            leaving.removeFromSuperview()
            animationInProgress = false
        })
    }
    
    @objc private func swipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right: moveRight()
        case .left: moveLeft()
        default: break
        }
    }
    
    private func makeViewWith(_ index: Int) -> UIImageView {
        let view = UIImageView(frame: headerView.frame)
        view.contentMode = .scaleAspectFill
        let subviewIndex = headerView.subviews.count - 2
        headerView.insertSubview(view, at: subviewIndex)   // ниже кнопок, чтобы кнопки не пропадали во время анимации
        view.image = images[index]
        return view
    }
}
