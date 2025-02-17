//
//  PhotoCollectionViewCell.swift
//  SocialApp
//
//  Created by Mina Emad on 16/02/2025.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var albumPhotoImageView: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    
    // MARK: - Cell-Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        photoLabel.isHidden = true
    }

}
