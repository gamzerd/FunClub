//
//  MediaDetailTableViewCell.swift
//  FunClub
//
//  Created by Gamze on 3/23/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

class MediaDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    /**
     * Setups cell.
     * @param mediaPath: image url of media.
     */
    func setup(with media: Media) {
        mediaImage.setImage(with: ItunesUtility.getProperImageUrl(url: media.artworkUrl100, size: 600))
    }
}
