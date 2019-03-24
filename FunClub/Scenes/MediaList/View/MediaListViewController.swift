//
//  MediaListViewController.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit
import RxSwift

final class MediaListViewController: UIViewController {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MediaListViewModelProtocol!
    weak var delegate: ShowDetailsCoordinatorDelegate!
    
    convenience init(viewModel: MediaListViewModelProtocol) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.getTitle()
        viewModel.load()
        collectionView.register(MediaListCollectionViewCell.self)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .done, target: self, action: #selector(rightButtonClickAction))
        registerForPreviewing(with: self, sourceView: collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // add delay to fix orientation changes
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.collectionView.reloadData()
        }
    }
    
    @objc func rightButtonClickAction() {
        viewModel.didFilterButtonClick()
    }
    
    func showMediaFilter(options: [MediaFilterOption]) {
    
        let alert = UIAlertController(title: "", message: "Please select a media type", preferredStyle: .actionSheet)
        options.forEach { option in
            let action = UIAlertAction(title: option.filterName, style: .default, handler:{ (UIAlertAction) in
                    self.viewModel.didMediaFilterOptionSelect(option: option.value)
                })
            let image = UIImage(named: "checked")
            if option.isSelected {
                action.setValue(image, forKey: "image")
            }
            alert.addAction(action)
        }
        
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension MediaListViewController: MediaListViewProtocol {
    
    /**
     * Shows Media list.
     */
    func showList() {
        self.collectionView.reloadData()
    }
    
    /**
     * Called when view model has an error.
     * @param message: to show in alert
     */
    func showAlert(alertTitle: String, alertMessage: String, buttonTitle: String?) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        if let title = buttonTitle {
            alert.addAction(UIAlertAction(title: title, style: .default, handler: { (UIAlertAction) in
                self.viewModel.didAlertButtonClick()
            }))
        }
        present(alert, animated: true, completion: nil)
    }
    
    /**
     * Opens detail page.
     */
    func openPage(media: Media) {
        delegate.showDetails(media: media, fromViewController: self)
    }
    
}

extension MediaListViewController: UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaListCollectionViewCell.identifier, for: indexPath) as! MediaListCollectionViewCell
        cell.setup(with: self.viewModel.list[indexPath.row])
        
        return cell
    }
}

extension MediaListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didRowSelect(index: indexPath.row)
    }
    
}

extension MediaListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = AppConstants.MediaCollection.getItemWidth(from: Float(collectionView.frame.width))
        let height = width * AppConstants.MediaCollection.imageRatio
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(AppConstants.MediaCollection.verticleSpaceBetweenItems)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(AppConstants.MediaCollection.horizontalSpaceBetweenItems) / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftMargin = CGFloat(AppConstants.MediaCollection.horizontalSpaceBetweenItems)
        let topMargin = CGFloat(AppConstants.MediaCollection.verticleSpaceBetweenItems)
        return UIEdgeInsets(top: topMargin, left: leftMargin, bottom: topMargin, right: leftMargin)
    }
}

extension MediaListViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView.indexPathForItem(at: location) else {
            return nil
        }
        
        return viewModel.didPressLong(index: indexPath.row)
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
}

extension MediaListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didSearchInputChange(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
}


