//
//  AlbumDetailsViewController.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var photosCollectionView: UICollectionView!

    // MARK: - Properties
    let items = Array(1...40) // Sample data
    let colors: [UIColor] = [.red, .blue, .green, .yellow, .orange, .purple, .cyan, .magenta, .brown, .gray]

    // MARK: - LifeCycle-Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
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
extension AlbumDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        cell.backgroundColor = colors[indexPath.item % colors.count]
        
        return cell
    }


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
