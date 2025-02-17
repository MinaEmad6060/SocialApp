//
//  SocialRepository.swift
//  SocialApp
//
//  Created by Mina Emad on 17/02/2025.
//

import Combine

//MARK: - Repository
protocol SocialRepositoryProtocol {
    func getUsers() -> AnyPublisher<[User], NetworkError>
    func getAlbums(userId: Int) -> AnyPublisher<[Album], NetworkError>
    func getPhotos(albumId: Int) -> AnyPublisher<[Photo], NetworkError>
}

final class SocialRepository {
    let dataSource: SocialRemoteDataSourceProtocol
    
    init(dependencies: SocialRepositoryDependenciesProtocol) {
        self.dataSource = dependencies.dataSource
    }
}

extension SocialRepository: SocialRepositoryProtocol{
    
    func getUsers() -> AnyPublisher<[User], NetworkError> {
        dataSource.getUsers()
            .eraseToAnyPublisher()
    }
    
    func getAlbums(userId: Int) -> AnyPublisher<[Album], NetworkError> {
        dataSource.getAlbums(userId: userId)
            .eraseToAnyPublisher()
    }
    
    func getPhotos(albumId: Int) -> AnyPublisher<[Photo], NetworkError> {
        dataSource.getPhotos(albumId: albumId)
            .eraseToAnyPublisher()
    }
    
}


//MARK: - Repository-Dependencies
protocol SocialRepositoryDependenciesProtocol {
    var dataSource: SocialRemoteDataSourceProtocol { get }
}

struct SocialsRepositoryDependencies: SocialRepositoryDependenciesProtocol {
    var dataSource: SocialRemoteDataSourceProtocol
}

