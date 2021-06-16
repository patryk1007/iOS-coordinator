//
//  LoginCoordinator.swift
//  CoordinatorTestApp
//
//  Created by Patryk Molka on 15/06/2021.
//

import Foundation

protocol LoginCoordinatorDelegate {
    func loginCoordinatorDidFinish(coordinaotr: Coordinator)
}

class LoginCoordinator: Coordinator {
    
    var children: [Coordinator] = []
    var delegate: LoginCoordinatorDelegate
    var router: Router
    
    init(router: Router, delegate: LoginCoordinatorDelegate) {
        self.router = router
        self.delegate = delegate
    }
    
    func present(animated: Bool) {
        self.presentLoginScreen(animated: animated)
    }
    
    func presentLoginScreen(animated: Bool) {
        router.present(LoginVC(delegate: self), animated: animated)
    }
}

extension LoginCoordinator: LoginVCDelegate {
    func loginVCDidFinish() {
        self.delegate.loginCoordinatorDidFinish(coordinaotr: self)
    }
}
