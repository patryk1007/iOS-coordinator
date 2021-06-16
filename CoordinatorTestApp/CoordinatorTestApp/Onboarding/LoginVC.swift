//
//  LoginVC.swift
//  CoordinatorTestApp
//
//  Created by Patryk Molka on 15/06/2021.
//

import Foundation
import UIKit

protocol LoginVCDelegate {
    func loginVCDidFinish()
}

class LoginVC: UIViewController {
    
    let delegate: LoginVCDelegate
    
    init(delegate: LoginVCDelegate){
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .blue
        self.navigationItem.hidesBackButton = true
        self.title = "Login View"
        self.addButton()
    }
    
    func addButton() {
        let button = UIButton()
        button.backgroundColor = UIColor.gray
        button.frame.size.width = 200
        button.frame.size.height = 50
        button.setTitle("Login Me", for: .normal)
        button.center = self.view.center
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        delegate.loginVCDidFinish()
    }
}
