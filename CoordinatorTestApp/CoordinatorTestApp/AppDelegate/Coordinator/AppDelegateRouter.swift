//
//  AppDelegateRouter.swift
//  CoordinatorTestApp
//
//  Created by Patryk Molka on 15/06/2021.
//

import Foundation
import UIKit

public class AppDelegateRouter: NSObject, Router {

    
    public let window: UIWindow
    
    @objc public init(window: UIWindow) {
        self.window = window
    }
    
    public func present(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    // Stubbed out methods
    public func dismiss(animated: Bool) {
    }
    
    public func presentModally(_ viewController: UIViewController, animated: Bool, onDismissed: (() -> Void)?) {}
    
    // Stubbed out methods
    public func popTo<T>(type: T.Type, animated: Bool) -> Bool {
        return true
    }
}
