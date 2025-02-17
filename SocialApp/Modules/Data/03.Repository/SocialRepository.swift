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
    
}


//MARK: - Repository-Dependencies
protocol SocialRepositoryDependenciesProtocol {
    var dataSource: SocialRemoteDataSourceProtocol { get }
}

struct SocialsRepositoryDependencies: SocialRepositoryDependenciesProtocol {
    var dataSource: SocialRemoteDataSourceProtocol
}

