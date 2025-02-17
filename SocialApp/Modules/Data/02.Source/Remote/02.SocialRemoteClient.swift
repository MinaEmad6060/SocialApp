//
//  02.SocialRemoteClient.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import Combine
import Moya
import CombineMoya
import Foundation

//MARK: - PROTOCOL
protocol SocialRemoteDataSourceProtocol {
    func getUsers() -> AnyPublisher<[User], NetworkError>
}


class SocialRemoteDataSource: SocialRemoteDataSourceProtocol {
    
    private let provider: MoyaProvider<SocialEndpoint> = MoyaProvider<SocialEndpoint>(
        plugins: [NetworkLoggerPlugin(configuration: .init(
            logOptions: [
                .successResponseBody,
                .errorResponseBody
            ]))]
    )

    func getUsers() -> AnyPublisher<[User], NetworkError> {
           return Future { [weak self] promise in
               guard let self = self else { return }
               self.provider.request(.getUsers) { result in
                   switch result {
                   case .success(let response):
                       do {
                           let users = try JSONDecoder().decode([User].self, from: response.data)
                           promise(.success(users))
                       } catch {
                           promise(.failure(NetworkError.decodingError(error)))
                       }
                   case .failure(let error):
                       promise(.failure(NetworkError.networkFailure(error)))
                   }
               }
           }
           .eraseToAnyPublisher()
    }

}
