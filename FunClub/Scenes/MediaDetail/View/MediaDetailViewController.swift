//
//  MediaDetailViewController.swift
//  FunClub
//
//  Created by Gamze on 3/23/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class MediaDetailViewController: UIViewController {
        
    @IBOutlet weak var mediaImageView: UIImageView!
    
    var viewModel: MediaDetailViewModelProtocol!
    
    convenience init(viewModel: MediaDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.getTitle()
        mediaImageView.setImage(with: viewModel.media.artworkUrl60)
    }
}
