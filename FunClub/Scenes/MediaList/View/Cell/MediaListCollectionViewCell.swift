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
    
    func setup(with cellViewModel: MediaListCellViewModel) {
        
        let media = cellViewModel.media
        titleLabel.text = media.trackName
        if AppConstants.MediaCollection.getNumberOfColumns() == 2 {
            mediaImageView.setImage(with: ItunesUtility.getProperImageUrl(url: media.artworkUrl100, size: 200))
        } else {
            mediaImageView.setImage(with: ItunesUtility.getProperImageUrl(url: media.artworkUrl100, size: 600))
        }
        
        if cellViewModel.isSelected {
            titleLabel.textColor = .green
        } else {
            titleLabel.textColor = .white
        }
    }
}
