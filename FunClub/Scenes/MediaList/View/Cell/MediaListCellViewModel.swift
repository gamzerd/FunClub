//
//  MediaListCellViewModel.swift
//  FunClub
//
//  Created by Gamze on 3/24/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

struct MediaListCellViewModel {
    
    var isSelected: Bool
    var media: Media
    
    init(isSelected: Bool, media: Media) {
        self.isSelected = isSelected
        self.media = media
    }
}
