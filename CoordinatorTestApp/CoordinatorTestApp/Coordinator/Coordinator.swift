//
//  Coordinator.swift
//  neos
//
//  Created by Dominic Bryan on 18/02/2021.
//  Copyright © 2021 Neos Ventures Ltd. All rights reserved.
//

import UIKit
// MARK: - Coordinator
protocol Coordinator:AnyObject {
    
    var children: [Coordinator] { get set }
    var router: Router { get }
    
    func present(animated: Bool)
    func dismiss(animated: Bool)
    func presentChild(_ child: Coordinator,
                      animated: Bool)
    func removeChild(_ child: Coordinator, animated: Bool) 
}

extension Coordinator {
    public func dismiss(animated: Bool) {
        router.dismiss(animated: animated)
    }
    
    public func presentChild(_ child: Coordinator,
                             animated: Bool) {
        children.append(child)
        child.present(animated: animated)
    }
    
    public func removeChild(_ child: Coordinator, animated: Bool) {
        guard let index = children.firstIndex(where:  { $0 === child })
        else {
            return
        }
        children.remove(at: index)
        child.dismiss(animated: animated)
    }
}
