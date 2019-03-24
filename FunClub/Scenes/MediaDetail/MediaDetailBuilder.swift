//
//  MediaDetailBuilder.swift
//  FunClub
//
//  Created by Gamze on 3/23/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

final class MediaDetailBuilder {
    
    static func make(with media: Media) -> MediaDetailViewController {
        
        let viewModel = MediaDetailViewModel(dataSource: app.dataSource, media: media)
        let viewController = MediaDetailViewController(viewModel: viewModel)
        return viewController
    }
}
