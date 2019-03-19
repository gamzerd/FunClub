//
//  ListViewBuilder.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class ListViewBuilder {
    
    static func make() -> ListViewController {
        
        //let viewModel = ListViewModel(dataSource: app.dataSource)
        //let viewController = ListViewController(viewModel: viewModel)
       
        let viewController = ListViewController()
        return viewController
        
    }
}
