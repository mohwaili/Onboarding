//
//  CarouselViewController.swift
//  GenericCarousel
//
//  Created by Mohammed Al Waili on 21/03/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import Foundation
import UIKit

protocol CarouselContainer: class {
    var holder: UIViewController { get }
    func embedCarousel<C, P>(_ carousel: C) where P: CarouselPageProtocol, C: CarouselViewController<P>
}

extension CarouselContainer where Self: UIViewController {
    
    var holder: UIViewController { self }
    
    func embedCarousel<C, P>(_ carousel: C) where P: CarouselPageProtocol, C: CarouselViewController<P> {
        carousel.view.translatesAutoresizingMaskIntoConstraints = false
        holder.view.addSubview(carousel.view)
        holder.addChild(carousel)
        NSLayoutConstraint.activate([
            carousel.view.leadingAnchor.constraint(equalTo: holder.view.leadingAnchor),
            carousel.view.trailingAnchor.constraint(equalTo: holder.view.trailingAnchor),
            carousel.view.topAnchor.constraint(equalTo: holder.view.topAnchor),
            carousel.view.bottomAnchor.constraint(equalTo: holder.view.bottomAnchor),
        ])
        carousel.didMove(toParent: holder)
    }
    
}

protocol CarouselPageProtocol: UIViewController {
    associatedtype ViewModel
    
    init()
    func configue(with viewModel: ViewModel)
}

enum CarouselPageOperation: Int {
    case next = 1
    case previous = -1
}

final class CarouselViewController<P: CarouselPageProtocol>: UIPageViewController {
    
    enum CarouselUpdate {
        case numberOfItems(num: Int)
        case viewModelChanged(viewModel: P.ViewModel, index: Int)
    }
    
    private let viewModels: Array<P.ViewModel>
    private let pages: Array<P>
    private let updateClosure: ((CarouselUpdate) -> Void)?
    var activePage: P? {
        didSet {
            guard
                let page = activePage,
                let index = pages.firstIndex(of: page) else { return }
            
            updateClosure?(.viewModelChanged(viewModel: viewModels[index], index: index))
        }
    }
    
    init(viewModels: Array<P.ViewModel>, pages: [P] = [], updateClosure: ((CarouselUpdate) -> Void)? = nil) {
        self.viewModels = viewModels
        self.pages = pages.isEmpty ? viewModels.map { _ in P() } : pages
        self.updateClosure = updateClosure
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented!")
    }
    
    private lazy var carouselDataSource: CarouselDataSource<P> = CarouselDataSource(carousel: self)
    private lazy var carouselDelegate: CarouselDelegate<P> = CarouselDelegate(carousel: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.dataSource = carouselDataSource
        self.delegate = carouselDelegate
        
        guard let firstPage = pages.first else { return }
        setViewModelChanged(for: firstPage)
        set(viewController: firstPage, animated: false) { [weak self] _ in
            guard let self = self else { return }
            self.updateClosure?(.numberOfItems(num: self.viewModels.count))
            self.updateClosure?(.viewModelChanged(viewModel: self.viewModels[0], index: 0))
        }
        
    }
    
    func nextPage() {
        guard
            let activePage = self.activePage,
            let nextPage = followingPage(activePage: activePage, operation: .next) else { return }
        setViewModelChanged(for: nextPage)
        set(viewController: nextPage, animated: true)
    }
    
    func previousPage() {
        guard
            let activePage = self.activePage,
            let previousPage = followingPage(activePage: activePage, operation: .previous) else { return }
        setViewModelChanged(for: previousPage)
        set(viewController: previousPage, direction: .reverse, animated: true)
    }
    
    func followingPage(activePage: P, operation: CarouselPageOperation) -> P? {
        guard let index = pages.firstIndex(of: activePage) else { return nil }
        let newIndex = index + operation.rawValue
        guard newIndex >= 0 && newIndex < viewModels.count else { return nil }
        let page = pages[newIndex]
        return page
    }
    
    private func set(
        viewController: P,
        direction: UIPageViewController.NavigationDirection = .forward,
        animated: Bool,
        completion: ((Bool) -> Void)? = nil) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: animated) { [weak self] completed in
                            guard let self = self else { return }
                            self.activePage = viewController
                            completion?(completed)
        }
        
    }
    
    func setViewModelChanged(for page: P) {
        page.configue(with: viewModels[pages.firstIndex(of: page) ?? 0])
    }
    
    func viewModel(at index: Int) -> P.ViewModel? {
        guard index >= 0 && index < pages.count else { return nil }
        return viewModels[index]
    }
    
}

class CarouselDataSource<P: CarouselPageProtocol>: NSObject, UIPageViewControllerDataSource {
    
    private weak var carousel: CarouselViewController<P>?
    
    init(carousel: CarouselViewController<P>) {
        self.carousel = carousel
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard
            let carouselPage = carousel?.activePage,
            let followingPage = carousel?.followingPage(activePage: carouselPage, operation: .previous) else { return nil }
        carousel?.setViewModelChanged(for: followingPage)
        return followingPage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let carouselPage = carousel?.activePage,
            let followingPage = carousel?.followingPage(activePage: carouselPage, operation: .next) else { return nil }
        carousel?.setViewModelChanged(for: followingPage)
        return followingPage
    }
    
}

class CarouselDelegate<P: CarouselPageProtocol>: NSObject, UIPageViewControllerDelegate {

    private weak var carousel: CarouselViewController<P>?
    
    init(carousel: CarouselViewController<P>) {
        self.carousel = carousel
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        carousel?.activePage = pageViewController.viewControllers?.first as? P
    }
    
}
