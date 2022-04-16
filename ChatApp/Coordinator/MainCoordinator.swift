//
//  MainCoordinator.swift
//  ChatApp
//
//  Created by LeeJaeHyeok on 2022/04/16.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    let rootViewController: ConversationsController
    
    init(rootViewController: ConversationsController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
    
    
    
    
}
