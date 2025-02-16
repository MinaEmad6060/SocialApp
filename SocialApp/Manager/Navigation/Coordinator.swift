//
//  Coordinator.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit

//MARK: - APP-COORDINATOR-PROTOCL
protocol CoordinatorProtocol {
    var coordinator: Coordinator? { get set }
}


//MARK: - APP-COORDINATOR
class Coordinator {
    
    //MARK: - PROPERTIES
    var navigationController: UINavigationController?

    //MARK: - INITIALIZER
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: - FUNCTIONS
    func pushViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }

}
