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
   
    var dataSource: DataSourceProtocol

    init(dataSource: DataSourceProtocol, media: Media) {
        self.dataSource = dataSource
        self.media = media
    }
    
    /**
     * Called to get title.
     */
    func getTitle() -> String {
        
        return "Selected Item"
    }
    
    func didDeleteButtonClick() {
        dataSource.addDeletedItem(id: self.media.trackId ?? 0)
    }
    
}
