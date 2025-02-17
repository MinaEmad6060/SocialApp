//
//  AlbumDetailsViewController.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit
import Combine
import Kingfisher

class AlbumDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var photosCollectionView: UICollectionView!

    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: SocialViewModelProtocol?
    private var albumId: Int?
    
    //Background colors act as placeholder in case of album photos can't be loaded
    let colors: [UIColor] = [.red, .blue, .green, .yellow, .orange, .purple, .cyan, .magenta, .brown, .gray]
    
    //MARK: - INITIALIZER
    init(viewModel: SocialViewModelProtocol, albumId: Int) {
        self.viewModel = viewModel
        self.albumId = albumId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - LifeCycle-Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindViewModel()
        viewModel?.getPhotos(albumId: albumId ?? 0)
    }
    
    
    // MARK: - Functions
    private func setupCollectionView() {
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        let nib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        photosCollectionView.register(nib, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
    }
}

// MARK: - Setup-CollectionView
extension AlbumDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.photos?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.photoLabel.text = viewModel?.photos?[indexPath.item].title
        
        cell.albumPhotoImageView.kf.setImage(
            with: URL(string: viewModel?.photos?[indexPath.item].url ?? ""),
            completionHandler: {[weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    print("Image loaded successfully: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Failed to load image: \(error.localizedDescription)")
                    cell.backgroundColor = self.colors[indexPath.item % self.colors.count]
                }
            }
        )
        
        return cell
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
