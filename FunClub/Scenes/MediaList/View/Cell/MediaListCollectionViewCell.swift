//
//  MediaListCollectionViewCell.swift
//  FunClub
//
//  Created by Gamze on 3/20/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

class MediaListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mediaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 4.0
        clipsToBounds = true
    }
    
    func setup(with media: Media) {
        titleLabel.text = media.wrapperType
        if AppConstants.MediaCollection.getNumberOfColumns() == 2 {
            mediaImageView.setImage(with: ItunesUtility.getProperImageUrl(url: media.artworkUrl100, size: 200))
        } else {
            mediaImageView.setImage(with: ItunesUtility.getProperImageUrl(url: media.artworkUrl100, size: 600))
        }
    }
}
