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
    var users: [UserDomain] { get set }
    var output: SocialViewModelOutput { get }

    func getUsers()
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
    
    var users: [UserDomain] = []
    var output: SocialViewModelOutput

    init(coordinator: SocialCoordinatorProtocol,
         useCase: SocialUseCaseProtocol,
         output: SocialViewModelOutput = SocialViewModelOutput()) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.output = output

        getUsers()
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
                self?.users = users
                self?.output.reloadView.send()
            }
            .store(in: &cancellables)
    }
    
}
