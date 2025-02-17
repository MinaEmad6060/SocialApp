//
//  SocialCoordinator.swift
//  SocialApp
//
//  Created by Mina Emad on 17/02/2025.
//


protocol SocialCoordinatorProtocol: Coordinator {
    func displayProfileScreen()
    func displayAlbumScreen(albumId: Int, albumName: String)
    func displayPhotoScreen(imageURL: String)
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
    
    func displayAlbumScreen(albumId: Int, albumName: String) {
        let viewModel = SocialViewModel(coordinator: self, useCase: socialUseCase())
        let viewController = AlbumDetailsViewController(viewModel: viewModel, albumId: albumId, albumName: albumName)
        self.router.push(viewController, animated: true)
    }
    
    func displayPhotoScreen(imageURL: String) {
        let viewController = PhotoDetailsViewController(imageURL: imageURL)
        self.router.present(viewController)
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
