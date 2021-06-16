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
      //  let dmsRouter = NavigationRouter(navigationController: )
      //  presentChild(<#T##child: Coordinator##Coordinator#>, animated: <#T##Bool#>)
    }
}

extension DashboardCoordinator: DMSCoordinatorDelegate {
    
    func dmsCoordinatorDidFinish(coordinaotr: Coordinator) {
        coordinaotr.removeChild(coordinaotr, animated: false)
    }
    
    func getBackToDashbaord(coordinaotr: Coordinator) {
        
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
    func backToDahboard() {
        self.presentMainView(animated: false)
    }
    

}
