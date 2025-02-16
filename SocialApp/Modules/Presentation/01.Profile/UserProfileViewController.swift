//
//  UserProfileViewController.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit

class UserProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var albumsTableView: UITableView!

    // MARK: - Properties
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

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
        print("Selected: \(items[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
