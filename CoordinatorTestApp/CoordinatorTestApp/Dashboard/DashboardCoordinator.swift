//
//  LoginCoordinator.swift
//  CoordinatorTestApp
//
//  Created by Patryk Molka on 15/06/2021.
//

import Foundation

protocol DashboardCoordinatorDelegate {
    func dashboardCoordinatorDidFinish(coordinaotr: Coordinator)
}

class DashboardCoordinator: Coordinator {
    
    var children: [Coordinator] = []
    var delegate: DashboardCoordinatorDelegate
    var router: Router
    
    init(router: Router, delegate: DashboardCoordinatorDelegate) {
        self.router = router
        self.delegate = delegate
    }
    
    func present(animated: Bool) {
        self.presentMainView(animated: animated)
    }
    
    func presentMainView(animated: Bool) {
        let gotBack = self.router.popTo(type: DashboardVC.self, animated: animated)
        if !gotBack {
            router.present(DashboardVC(delegate: self), animated: animated)
        }
    }
    
    func presentDeviceDetail(animated: Bool) {
        router.present(DeviceDetailsVC(delegate: self), animated: animated)
    }
    
    func presentDMS() {
        guard let navigationController = router.navigationController else {
            return
        }
        let dmsRouter = NavigationRouter(navigationController: navigationController)
        let dmsCoordinator = DMSCoordinator(router: dmsRouter, delegate: self)
        presentChild(dmsCoordinator, animated: true)
    }
}

extension DashboardCoordinator: DMSCoordinatorDelegate {
    
    func dmsCoordinatorDidFinish(coordinaotr: Coordinator) {
        coordinaotr.dismiss(animated: true)
    }
    
    func getBackToDashbaord(coordinaotr: Coordinator) {
        self.presentMainView(animated: true)
    }
    
    
}

extension DashboardCoordinator: DashboardVCDelegate {
    func openDetailsPage() {
        self.presentDeviceDetail(animated: true)
    }
    
    func dashboardDidFinish() {
        self.delegate.dashboardCoordinatorDidFinish(coordinaotr: self)
    }
}

extension DashboardCoordinator: DeviceDetailsVCDelegate {
    func openDMS() {
        self.presentDMS()
    }
    
    func backToDahboard() {
        self.presentMainView(animated: true)
    }
    

}
