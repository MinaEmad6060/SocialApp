//
//  SocialCoordinator.swift
//  SocialApp
//
//  Created by Mina Emad on 17/02/2025.
//


protocol SocialCoordinatorProtocol: Coordinator {
    func displayProfileScreen()
    func displayAlbumScreen()
}


//MARK: - APP-COORDINATOR
final class socialCoordinator: SocialCoordinatorProtocol {
 
    var router: any Router
    
    init(router: Router) {
        self.router = router
    }
    
    func displayProfileScreen() {
        let viewModel = SocialViewModel(coordinator: self, useCase: socialUseCase())
        let viewController = UserProfileViewController(viewModel: viewModel)
        self.router.push(viewController, animated: true)
    }
    
    func displayAlbumScreen() {
        let viewModel = SocialViewModel(coordinator: self, useCase: socialUseCase())
        let viewController = AlbumDetailsViewController(viewModel: viewModel)
        self.router.push(viewController, animated: true)
    }
    
}


//MARK: - Init-UseCase
extension socialCoordinator {
    
    private func socialUseCase() -> SocialUseCaseProtocol {
        let repository = SocialRepository(dependencies: SocialsRepositoryDependencies(dataSource: SocialRemoteDataSource()))
        let useCase = SocialUseCase(dependencies: SocialUseCaseDependencies(repository: repository))
        return useCase
    }
    
}
