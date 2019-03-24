//
//  MediaDetailViewController.swift
//  FunClub
//
//  Created by Gamze on 3/23/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

final class MediaDetailViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!

    var viewModel: MediaDetailViewModelProtocol!
    
    convenience init(viewModel: MediaDetailViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.getTitle()
        tableView.register(MediaDetailTableViewCell.self)
        
        let image = UIImage(named: "delete")
        let button = UIButton(type: .system)
        
        button.setImage((image), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        
    }
    
    @objc func deleteButtonClicked() {
        viewModel.didDeleteButtonClick()
    }
}

extension MediaDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MediaDetailTableViewCell.identifier) as! MediaDetailTableViewCell
        cell.setup(with: viewModel.media)
        
        return cell
    }
}
