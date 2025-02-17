//
//  UserProfileViewController.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit
import Combine

class UserProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var albumsTableView: UITableView!

    // MARK: - Properties
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
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
        setupTableView()
    }
    
    // MARK: - Functions
    private func setupTableView() {
        albumsTableView.delegate = self
        albumsTableView.dataSource = self
        albumsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

// MARK: - Setup-TableView
extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let coordinator = socialCoordinator(router: AppRouter(navigationController: navigationController!))
        coordinator.displayAlbumScreen()
    }
    
}
