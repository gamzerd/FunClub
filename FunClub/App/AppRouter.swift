//
//  AppRouter.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class AppRouter {
    
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    /**
     * Sets rootViewController.
     */
    func start() {
        let viewController = MediaListBuilder.make()
        viewController.delegate = self
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

protocol ShowDetailsCoordinatorDelegate: class {
    func showDetails(media: Media, fromViewController: UIViewController)
}

extension AppRouter: ShowDetailsCoordinatorDelegate {
    
    /**
     * Shows details of media list.
     * @param media: media model, fromViewController: controller to show detail
     */
    func showDetails(media: Media, fromViewController: UIViewController) {
        
        let mediaDetailVC = MediaDetailBuilder.make(with: media)
        fromViewController.show(mediaDetailVC, sender: nil)
    }
}
