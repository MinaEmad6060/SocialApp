//
//  SocialUseCase.swift
//  SocialApp
//
//  Created by Mina Emad on 17/02/2025.
//

import Combine


//MARK: - UseCase
protocol SocialUseCaseProtocol {
    func getUsers() -> AnyPublisher<[UserDomain], NetworkError>
    func getAlbums(userId: Int) -> AnyPublisher<[AlbumDomain], NetworkError>
    func getPhotos(albumId: Int) -> AnyPublisher<[PhotoDomain], NetworkError>
}


final class SocialUseCase {
    let repository: SocialRepositoryProtocol
    init(dependencies: SocialUseCaseDependanciesProtocol) {
        self.repository = dependencies.repository
    }
}

extension SocialUseCase: SocialUseCaseProtocol {
    
    func getUsers() -> AnyPublisher<[UserDomain], NetworkError> {
        repository.getUsers()
            .map { entities in
                entities.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
    
    func getAlbums(userId: Int) -> AnyPublisher<[AlbumDomain], NetworkError> {
        repository.getAlbums(userId: userId)
            .map { entities in
                entities.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
    
    func getPhotos(albumId: Int) -> AnyPublisher<[PhotoDomain], NetworkError> {
        repository.getPhotos(albumId: albumId)
            .map { entities in
                entities.map { $0.toDomain() }
            }
            .eraseToAnyPublisher()
    }
    
}



//MARK: - UseCase-Dependancies
protocol SocialUseCaseDependanciesProtocol{
    var repository: SocialRepositoryProtocol { get }
}


struct SocialUseCaseDependencies: SocialUseCaseDependanciesProtocol {
    var repository: SocialRepositoryProtocol
}
