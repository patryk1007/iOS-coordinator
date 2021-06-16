//
//  LoginVC.swift
//  CoordinatorTestApp
//
//  Created by Patryk Molka on 15/06/2021.
//

import Foundation
import UIKit

protocol DeviceDetailsVCDelegate {
    func backToDahboard()
    func openDMS()
}

class DeviceDetailsVC: UIViewController {
    
    let delegate: DeviceDetailsVCDelegate
    
    init(delegate: DeviceDetailsVCDelegate){
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .orange
        self.navigationItem.hidesBackButton = true
        self.title = "Device details"
        self.addButton()
        self.addDMSButton()
    }
    
    func addDMSButton() {
        let button = UIButton()
        button.backgroundColor = UIColor.gray
        button.frame.size.width = 200
        button.frame.size.height = 50
        button.setTitle("Open DMS", for: .normal)
        button.center = self.view.center
        button.addTarget(self, action: #selector(buttonDMSAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    
    @objc func buttonDMSAction(sender: UIButton!) {
        delegate.openDMS()
    }
    
    func addButton() {
        let button = UIButton()
        button.backgroundColor = UIColor.gray
        button.frame.size.width = 200
        button.frame.size.height = 50
        button.setTitle("Back to dashboard", for: .normal)
        var position = self.view.center
        position.y += 60
        button.center = position
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        delegate.backToDahboard()
    }
}
