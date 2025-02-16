//
//  Coordinator.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit

//MARK: - COORDINATOR-PROTOCL
protocol Coordinator {
    var router: Router { get }
    
    func displayProfileScreen()
}


//MARK: - APP-COORDINATOR-IMPLEMENTATION
final class AppCoordinator: Coordinator {
    
    var router: any Router
    
    init(router: Router) {
        self.router = router
    }
    
    func displayProfileScreen() {
        let viewController = AlbumDetailsViewController()
        self.router.push(viewController, animated: true)
    }
    
    
}


//MARK: - INIT-USE-CASES
extension AppCoordinator {
    
//    private func profileUseCase() -> ProfileUseCaseProtocol {
//        let repository = HotelsRepository(dependencies: HotelsRepositoryDependencies(dataSource: HotelsRemoteDataSource()))
//        let useCase = HotelsHomeUseCase(dependencies: HotelsUseCaseDependencies(repository: repository))
//        return useCase
//    }
    
}
