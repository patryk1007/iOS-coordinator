//
//  AppDelegateCoordinator.swift
//  CoordinatorTestApp
//
//  Created by Patryk Molka on 15/06/2021.
//

import Foundation
import UIKit

class AppDelegateCoordinator: Coordinator {
     
    var children: [Coordinator] = []
    var router: Router
    
    private lazy var rootView: UINavigationController = {
        let vc = UIViewController()
        let navc = UINavigationController()
        navc.viewControllers = [vc]
        navc.view.backgroundColor = .red
        return navc
    }()
    
    init(router: AppDelegateRouter) {
        self.router = router
    }
    
    func present(animated: Bool) {
        self.router.present(self.rootView, animated: animated)
        self.presentFirstChildView()
    }
    
    func presentFirstChildView() {
        let router = NavigationRouter(navigationController: rootView, routerRootController: rootView)
        let loginCoordinator = LoginCoordinator(router: router, delegate: self)
        self.presentChild(loginCoordinator, animated: false)
    }
    
    func presentDashboard() {
        let router = NavigationRouter(navigationController: rootView)
        let loginCoordinator = DashboardCoordinator(router: router, delegate: self)
        self.presentChild(loginCoordinator, animated: false)
    }
}

extension AppDelegateCoordinator: LoginCoordinatorDelegate {
    func loginCoordinatorDidFinish(coordinaotr: Coordinator) {
        self.removeChild(coordinaotr, animated: false)
        self.presentDashboard()
        
    }
}

extension AppDelegateCoordinator: DashboardCoordinatorDelegate {
    func dashboardCoordinatorDidFinish(coordinaotr: Coordinator) {
        self.removeChild(coordinaotr, animated: false)
        self.presentFirstChildView()
    }
}
