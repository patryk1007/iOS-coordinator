//
//  LoginVC.swift
//  CoordinatorTestApp
//
//  Created by Patryk Molka on 15/06/2021.
//

import Foundation
import UIKit

protocol DMSVCVCDelegate {
    func dmsVCDidFinish()
    func getBackToDashboard()
}

class DMSVC: UIViewController {
    
    let delegate: DMSVCVCDelegate
    
    init(delegate: DMSVCVCDelegate){
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .green
        self.navigationItem.hidesBackButton = true
        self.title = "DMS VIEW"
        self.addButton()
        self.addDetailsButton()
    }
    
    func addDetailsButton() {
        let button = UIButton()
        button.backgroundColor = UIColor.gray
        button.frame.size.width = 200
        button.frame.size.height = 50
        button.setTitle("Close DMS", for: .normal)
        button.center = self.view.center
        button.addTarget(self, action: #selector(buttonDetailsAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    @objc func buttonDetailsAction(sender: UIButton!) {
        delegate.dmsVCDidFinish()
    }
    
    func addButton() {
        let button = UIButton()
        button.backgroundColor = UIColor.gray
        button.frame.size.width = 200
        button.frame.size.height = 50
        button.setTitle("Get back to dashboard", for: .normal)
        var position = self.view.center
        position.y += 60
        button.center = position
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        delegate.getBackToDashboard()
    }
}
