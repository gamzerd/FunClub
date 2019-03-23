//
//  MediaDetailViewModel.swift
//  FunClub
//
//  Created by Gamze on 3/23/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

final class MediaDetailViewModel: MediaDetailViewModelProtocol {
    
    var media: Media
    
    init(media: Media) {
        self.media = media
    }
    
    /**
     * Called to get title.
     */
    func getTitle() -> String {
        
        return "Selected Item"
    }
    
    /**
     * Called to get image path.
     */
    func getImagePath() -> String {
        
        return media.artworkUrl60
    }
    
}
