//
//  LoginCoordinator.swift
//  CoordinatorTestApp
//
//  Created by Patryk Molka on 15/06/2021.
//

import Foundation

protocol DMSCoordinatorDelegate {
    func dmsCoordinatorDidFinish(coordinaotr: Coordinator)
    func getBackToDashbaord(coordinaotr: Coordinator)
}

class DMSCoordinator: Coordinator {
    
    var children: [Coordinator] = []
    var delegate: DMSCoordinatorDelegate
    var router: Router
    
    init(router: Router, delegate: DMSCoordinatorDelegate) {
        self.router = router
        self.delegate = delegate
    }
    
    func present(animated: Bool) {
        self.presentMainView(animated: animated)
    }
    
    func presentMainView(animated: Bool) {
        let gotBack = self.router.popTo(type: DMSVC.self, animated: animated)
        if !gotBack {
            router.present(DMSVC(delegate: self), animated: animated)
        }
    }
}

extension DMSCoordinator: DMSVCVCDelegate {
    func dmsVCDidFinish() {
        delegate.dmsCoordinatorDidFinish(coordinaotr: self)
    }
    
    func getBackToDashboard() {
        delegate.getBackToDashbaord(coordinaotr: self)
    }
    

    
}
