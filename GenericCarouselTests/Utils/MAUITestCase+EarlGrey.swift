//
//  XCTestCase+EarlGrey.swift
//  GenericCarouselTests
//
//  Created by Mohammed Al Waili on 23/07/2020.
//  Copyright © 2020 Mohammed Al Waili. All rights reserved.
//

import XCTest
import EarlGrey

extension MAUITestCase {
    
    open func open(viewController: UIViewController,
                   modally: Bool = false,
                   embedInNavigation: Bool = false,
                   embedInTabbar: Bool = false) {
        var viewControllerToOpen = viewController
        if embedInNavigation {
            viewControllerToOpen = embedInNavigationController(viewController)
        }
        
        if embedInTabbar {
            let tabbarController = UITabBarController(nibName: nil, bundle: nil)
            tabbarController.viewControllers = [viewControllerToOpen]
            viewControllerToOpen = tabbarController
        }
        viewControllerToOpen.modalPresentationStyle = .fullScreen
        
        if modally {
            UIWindow.keyMAWindow.set(rootViewController: UIViewController())
            UIWindow.keyMAWindow.rootViewController?.present(viewControllerToOpen,
                                                               animated: true,
                                                               completion: nil)
        } else {
            UIWindow.keyMAWindow.set(rootViewController: viewControllerToOpen)
        }
    }
    
    private func embedInNavigationController(_ viewController: UIViewController) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    @discardableResult func waitToBeVisible(_ viewControllerType: UIViewController.Type) -> Bool {
        let success = GREYCondition.init(name: "Wait ViewController to be visible", block: { () -> Bool in
            
            guard let rootViewController = UIWindow.keyMAWindow.rootViewController else { return false }
            let viewController = self.topViewController(rootViewController)
            return viewController.isKind(of: viewControllerType)
        }).wait(withTimeout: 10)
        
        return success
    }
    
    private func topViewController(_ rootViewController: UIViewController) -> UIViewController {
        var viewController: UIViewController?
        
        switch rootViewController {
        case let navigationController as UINavigationController:
            viewController = navigationController.topViewController
        case let tabBarController as UITabBarController:
            viewController = tabBarController.selectedViewController
        case let splitViewController as UISplitViewController:
            viewController = splitViewController.viewControllers.last
        default:
            viewController = rootViewController.presentedViewController
        }
        guard let nextViewController = viewController else {
            return rootViewController
        }
        return topViewController(nextViewController)
    }
}
