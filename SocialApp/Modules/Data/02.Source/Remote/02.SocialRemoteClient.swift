//
//  02.SocialRemoteClient.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import Combine
import Moya
import Foundation


protocol SocialRemoteDataSourceProtocol {
    func getUsers() -> AnyPublisher<[User], NetworkError>
    func getAlbums(userId: Int) -> AnyPublisher<[Album], NetworkError>
    func getPhotos(albumId: Int) -> AnyPublisher<[Photo], NetworkError>
}


class SocialRemoteDataSource {
    private let provider: MoyaProvider<SocialEndpoint> = MoyaProvider<SocialEndpoint>(
        plugins: [NetworkLoggerPlugin(configuration: .init(
            logOptions: [
                .successResponseBody,
                .errorResponseBody
            ]))]
    )
}

extension SocialRemoteDataSource: SocialRemoteDataSourceProtocol {
    
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
    
    
    func getAlbums(userId: Int) -> AnyPublisher<[Album], NetworkError> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            self.provider.request(.getUserAlbums(userId: userId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let albums = try JSONDecoder().decode([Album].self, from: response.data)
                        promise(.success(albums))
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
    
    
    func getPhotos(albumId: Int) -> AnyPublisher<[Photo], NetworkError> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            self.provider.request(.getAlbumPhotos(albumId: albumId)) { result in
                switch result {
                case .success(let response):
                    do {
                        let photos = try JSONDecoder().decode([Photo].self, from: response.data)
                        promise(.success(photos))
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
