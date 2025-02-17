//
//  AlbumDetailsViewController.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit
import Combine
import CombineCocoa
import Kingfisher

class AlbumDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var btnBackOutlet: UIButton!
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: SocialViewModelProtocol?
    private var albumId: Int?
    private var albumName: String?
    
    //Background colors act as placeholder in case of album photos can't be loaded
    let colors: [UIColor] = [.red, .blue, .green, .yellow, .orange, .purple, .cyan, .magenta, .brown, .gray]
    
    private var filteredPhotos: [PhotoDomain] = []
    private var isSearching = false
    
    //MARK: - INITIALIZER
    init(viewModel: SocialViewModelProtocol, albumId: Int, albumName: String) {
        self.viewModel = viewModel
        self.albumId = albumId
        self.albumName = albumName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle-Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewcontroller()
        bindViewModel()
    }
    
    
    // MARK: - Functions
    private func initViewcontroller() {
        setupViews()
        setupCollectionView()
        setupSearchBar()
        bindTapOnBackButton()
    }
    
    private func setupViews() {
        self.navigationItem.hidesBackButton = true
        self.albumNameLabel.text = albumName
        viewModel?.getPhotos(albumId: albumId ?? 0)
    }
    
    
    private func bindTapOnBackButton() {
        btnBackOutlet.setTitle("", for: .normal)
        btnBackOutlet.tapPublisher
            .sink { [weak self] in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellables)
    }
    
    
    // MARK: - init-CollectionView
    private func setupCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        photosCollectionView.register(nib, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
    }
    
    
    // MARK: - Setup-SearchBar
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
        
    @objc private func searchTextChanged() {
        guard let text = searchBar.text?.lowercased(), !text.isEmpty else {
            isSearching = false
            photosCollectionView.reloadData()
            return
        }

        isSearching = true
        filteredPhotos = viewModel?.photos?.filter { photo in
            guard let title = photo.title?.lowercased() else { return false }
            return title.contains(text)
        } ?? []

        photosCollectionView.reloadData()
    }

}

// MARK: - CollectionView DataSource & Delegate
extension AlbumDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredPhotos.count : viewModel?.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        let photo = isSearching ? filteredPhotos[indexPath.item] : viewModel?.photos?[indexPath.item]
        
        
        cell.albumPhotoImageView.kf.setImage(
            with: URL(string: photo?.thumbnailUrl ?? ""),
            completionHandler: { [weak self] result in
                guard let self = self else { return }
                if case .failure(_) = result {
                    cell.photoLabel.isHidden = false
                    cell.photoLabel.text = "600x600"
                    cell.backgroundColor = self.colors[indexPath.item % self.colors.count]
                }
            }
        )
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let photo = isSearching ? filteredPhotos[indexPath.item] : viewModel?.photos?[indexPath.item]
        print("didSelectItemPublisher")
        let coordinator = SocialCoordinator(router: AppRouter(navigationController: self.navigationController!))
        coordinator.displayPhotoScreen(imageURL: photo?.url ?? "")
    }
}
    
// MARK: - Setup-CollectionView-Layout
extension AlbumDetailsViewController: UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 3
        let cellWidth = collectionView.frame.width / numberOfColumns
        return CGSize(width: cellWidth, height: cellWidth)
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

// MARK: - UISearchBarDelegate
extension AlbumDetailsViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        photosCollectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}


//MARK: - VIEW MODEL BINDING
private extension AlbumDetailsViewController {
    func bindViewModel() {
        bindReloadView()
    }
    
    func bindReloadView() {
        viewModel?.output.reloadView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                photosCollectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}
