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
}



//MARK: - UseCase-Dependancies
protocol SocialUseCaseDependanciesProtocol{
    var repository: SocialRepositoryProtocol { get }
}


struct SocialUseCaseDependencies: SocialUseCaseDependanciesProtocol {
    var repository: SocialRepositoryProtocol
}
