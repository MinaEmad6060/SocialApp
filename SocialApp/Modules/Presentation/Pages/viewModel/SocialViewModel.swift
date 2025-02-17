//
//  SocialViewModel.swift
//  SocialApp
//
//  Created by Mina Emad on 17/02/2025.
//

import Foundation
import Combine

//MARK: - PROTOCOL
protocol SocialViewModelProtocol{
    var user: UserDomain? { get set }
    var albums: [AlbumDomain]? { get set }
    var photos: [PhotoDomain]? { get set }
    var output: SocialViewModelOutput { get }

    func getUsers()
    func getAlbums(userId: Int)
    func getPhotos(albumId: Int)
}

//MARK: - ViewModel-Output
struct SocialViewModelOutput {
    let isLoading: PassthroughSubject<Bool, Never> = .init()
    let reloadView: PassthroughSubject<Void, Never> = .init()
    let showToast: PassthroughSubject<Void, Never> = .init()
}


//MARK: - IMPLEMENTATION
class SocialViewModel: SocialViewModelProtocol {
    
    private let coordinator: Coordinator
    private var useCase: SocialUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    var user: UserDomain?
    var albums: [AlbumDomain]?
    var photos: [PhotoDomain]?
    var output: SocialViewModelOutput

    init(coordinator: SocialCoordinatorProtocol,
         useCase: SocialUseCaseProtocol,
         output: SocialViewModelOutput = SocialViewModelOutput()) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.output = output
    }
    
}


//MARK: - CALLS
extension SocialViewModel {
    
    func getUsers() {
        coordinator.showLoader()
        useCase.getUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                coordinator.hideLoader()
                switch completion {
                    case .finished: print("Completed")
                    case .failure(let error): print(error.localizedDescription)
                }
            } receiveValue: { [weak self] users in
                if let randomUser = users.randomElement() {
                    self?.user = randomUser
                    self?.getAlbums(userId: randomUser.id ?? 0)
                }
            }
            .store(in: &cancellables)
    }
    
    func getAlbums(userId: Int) {
        coordinator.showLoader()
        useCase.getAlbums(userId: userId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                coordinator.hideLoader()
                switch completion {
                    case .finished: print("Completed")
                    case .failure(let error): print(error.localizedDescription)
                }
            } receiveValue: { [weak self] albums in
                self?.albums = albums
                self?.output.reloadView.send()
            }
            .store(in: &cancellables)
    }
    
    func getPhotos(albumId: Int) {
        coordinator.showLoader()
        useCase.getPhotos(albumId: albumId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                coordinator.hideLoader()
                switch completion {
                    case .finished: print("Completed")
                    case .failure(let error): print(error.localizedDescription)
                }
            } receiveValue: { [weak self] photos in
                self?.photos = photos
                self?.output.reloadView.send()
            }
            .store(in: &cancellables)
    }
    
}
