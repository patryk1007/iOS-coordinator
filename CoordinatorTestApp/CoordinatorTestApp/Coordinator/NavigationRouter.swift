//
//  NavigationRouter.swift
//  neos
//
//  Created by Dominic Bryan on 18/02/2021.
//  Copyright © 2021 Neos Ventures Ltd. All rights reserved.
//

import UIKit

// MARK: - Navigation Router
public class NavigationRouter: NSObject {
    public var navigationController: UINavigationController?
    
    private var routerRootController: UIViewController?
    private var onDismissForViewController: [UIViewController: (()->Void)] = [:]
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.routerRootController = navigationController.viewControllers.last
        super.init()
        self.navigationController?.delegate = self
    }
    
    public init(navigationController: UINavigationController, routerRootController: UIViewController) {
        self.navigationController = navigationController
        self.routerRootController = routerRootController
        super.init()
        self.navigationController?.delegate = self
    }
    
    public func updateRootView(routerRootController: UIViewController?) {
        self.routerRootController = routerRootController
    }
}

extension NavigationRouter: Router {
    
    public func popTo<T>(type: T.Type, animated: Bool) -> Bool {
        guard let navigationController = self.navigationController, let vc = navigationController.viewControllers.first(where:  { ($0 as? T) != nil  }) else {
            return false
        }
        navigationController.popToViewController(vc, animated: animated)
        return true
    }
    
    public func present(_ viewController: UIViewController,
                        animated: Bool,
                        onDismissed: (()->Void)?) {
        onDismissForViewController[viewController] = onDismissed
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func presentModally(_ viewController: UIViewController, animated: Bool, onDismissed: (()->Void)?) {
        onDismissForViewController[viewController] = onDismissed
        navigationController?.present(viewController, animated: true, completion: nil)
    }
    
    public func dismiss(animated: Bool) {
        guard let routerRootController = routerRootController, (self.navigationController?.viewControllers.contains { $0 == routerRootController } == true)
        else {
            navigationController?.popToRootViewController(animated: animated)
            return
        }
        performOnDismissed(for: routerRootController)
        navigationController?.popToViewController(routerRootController, animated: animated)
    }
    
    private func performOnDismissed(for viewController: UIViewController) {
        guard let onDismiss = onDismissForViewController[viewController] else {
            return
        }
        onDismiss()
        onDismissForViewController[viewController] = nil
    }
}

extension NavigationRouter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let dismissedViewController =
                navigationController.transitionCoordinator?.viewController(forKey: .from),
              !navigationController.viewControllers.contains(dismissedViewController) else {
            return
        }
        performOnDismissed(for: dismissedViewController)
    }
}

// MARK: - Router
public protocol Router: AnyObject {
    var navigationController: UINavigationController? {get}
    
    func present(_ viewController: UIViewController, animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool, onDismissed: (()->Void)?)
    func presentModally(_ viewController: UIViewController, animated: Bool)
    func presentModally(_ viewController: UIViewController, animated: Bool, onDismissed: (()->Void)?)
    func dismiss(animated: Bool)
    func popTo<T>(type: T.Type, animated: Bool) -> Bool
}

extension Router {
    public func present(_ viewController: UIViewController,
                        animated: Bool) {
        present(viewController, animated: animated, onDismissed: nil)
    }
    
    public func presentModally(_ viewController: UIViewController, animated: Bool) {
        presentModally(viewController, animated: animated, onDismissed: nil)
    }
}
