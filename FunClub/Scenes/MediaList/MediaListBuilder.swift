//
//  MediaListBuilder.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class MediaListBuilder {
    
    static func make() -> MediaListViewController {
        
        let viewModel = MediaListViewModel(dataSource: app.dataSource)
        let viewController = MediaListViewController(viewModel: viewModel)
        return viewController
        
    }
}
