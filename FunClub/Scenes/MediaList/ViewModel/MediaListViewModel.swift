//
//  MediaListViewModel.swift
//  FunClub
//
//  Created by Gamze on 3/20/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit
import RxSwift

final class MediaListViewModel: MediaListViewModelProtocol {
    
    var list: [Media] = []
        
    // used to unsubscribe from RxSwift updates when deinit is called
    var disposeBag = DisposeBag()
    
    var delegateIndex = 0
    
    weak var viewDelegate: MediaListViewProtocol?
    
    let dataSource: DataSourceProtocol
    
    init (dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    /**
     * Called to get title.
     */
    func getTitle() -> String {
        return "Media List"
    }
    
    /**
     * Called when a row of the product list is selected.
     * @param index: index of the selected section.
     */
    func didRowSelect(index: Int) {
        //viewDelegate?.openPage(product: list[index])
    }
    
    /**
     * Makes api call to get the list.
     */
    func load() {
        
        if !CheckInternet.connection() {
            viewDelegate?.showAlert(alertTitle: "Warning", alertMessage: "You are not connected to the internet!", buttonTitle: "Retry")
        }
        
        dataSource.getSearchResult(term: "lost", country: "US", media: "all")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                self.list.append(contentsOf: response.results)
            }, onError: { _ in
                self.viewDelegate?.showAlert(alertTitle: "Error", alertMessage: "Fetching list failed!", buttonTitle: "Retry")
            }, onCompleted: {
                self.viewDelegate?.showList()
            }).disposed(by: self.disposeBag)
        
    }
    
    /**
     * Called when user clicks button in alert.
     */
    func didAlertButtonClick() {
        
        load()
    }
    
    /**
     * Called when cell pressed long.
     * @param index: index of the selected row.
     * @return MediaDetailViewController: controller to show
     */
    func didPressLong(index: Int) -> UIViewController {
        
//        let detailViewModel = MediaDetailViewModel(product: list[index])
//        return MediaDetailBuilder.make(with: detailViewModel)
        return UIViewController()
    }
}
