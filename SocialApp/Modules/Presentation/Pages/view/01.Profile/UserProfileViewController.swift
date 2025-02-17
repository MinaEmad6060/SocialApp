//
//  UserProfileViewController.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit
import Combine
import CombineCocoa

class UserProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var albumsTableView: UITableView!

    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: SocialViewModelProtocol?
    
    //MARK: - INITIALIZER
    init(viewModel: SocialViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle-Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewcontroller()
        
        bindReloadView()
    }
    
    // MARK: - Faunctions
    private func initViewcontroller() {
        self.navigationItem.hidesBackButton = true
        setupTableView()
        viewModel?.getUsers()
    }
    
    // MARK: - init-TableView
    private func setupTableView() {
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
        albumsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        setupTableViewBindings()
    }
    
    private func setupTableViewBindings() {
        albumsTableView.didSelectRowPublisher
            .sink { [weak self] indexPath in
                guard let self = self else { return }
                self.albumsTableView.deselectRow(at: indexPath, animated: true)
                
                let coordinator = SocialCoordinator(router: AppRouter(navigationController: self.navigationController!))
                coordinator.displayAlbumScreen(albumId: self.viewModel?.albums?[indexPath.row].id ?? 0, albumName: self.viewModel?.albums?[indexPath.row].title ?? "")
            }
            .store(in: &cancellables)
    }

}

// MARK: - Setup-TableView
extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.albums?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel?.albums?[indexPath.row].title
        return cell
    }

}


//MARK: - VIEW MODEL BINDING
private extension UserProfileViewController {
    
    func bindReloadView() {
        viewModel?.output.reloadView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                userNameLabel.text = self.viewModel?.user?.name
                userAddressLabel.text = "\(self.viewModel?.user?.address?.street ?? ""), \(self.viewModel?.user?.address?.city ?? ""), \(self.viewModel?.user?.address?.suite ?? ""), \(self.viewModel?.user?.address?.zipcode ?? "")"
                albumsTableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}
