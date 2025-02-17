//
//  SocialCoordinator.swift
//  SocialApp
//
//  Created by Mina Emad on 17/02/2025.
//


protocol SocialCoordinatorProtocol: Coordinator {
    func displayProfileScreen()
    func displayAlbumScreen(albumId: Int)
}


//MARK: - APP-COORDINATOR
final class SocialCoordinator: SocialCoordinatorProtocol {
 
    var router: any Router
    
    init(router: Router) {
        self.router = router
    }
    
    func displayProfileScreen() {
        let viewModel = SocialViewModel(coordinator: self, useCase: socialUseCase())
        let viewController = UserProfileViewController(viewModel: viewModel)
        self.router.push(viewController, animated: true)
    }
    
    func displayAlbumScreen(albumId: Int) {
        let viewModel = SocialViewModel(coordinator: self, useCase: socialUseCase())
        let viewController = AlbumDetailsViewController(viewModel: viewModel, albumId: albumId)
        self.router.push(viewController, animated: true)
    }
    
}


//MARK: - Init-UseCase
extension SocialCoordinator {
    
    private func socialUseCase() -> SocialUseCaseProtocol {
        let repository = SocialRepository(dependencies: SocialsRepositoryDependencies(dataSource: SocialRemoteDataSource()))
        let useCase = SocialUseCase(dependencies: SocialUseCaseDependencies(repository: repository))
        return useCase
    }
    
}
