//
//  MediaListViewModel.swift
//  FunClub
//
//  Created by Gamze on 3/20/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit
import RxSwift

final class MediaListViewModel: MediaListViewModelProtocol, DataSourceDelegateProtocol {
    
    let limit = 100
    
    var list: [MediaListCellViewModel] = []
    
    var searchTimer: Timer?

    // used to unsubscribe from RxSwift updates when deinit is called
    var disposeBag = DisposeBag()
    
    var delegateIndex = 0
    
    var selectedOption = "all"
    
    var searchText = ""
    
    weak var viewDelegate: MediaListViewProtocol?
    
    let dataSource: DataSourceProtocol
    
    init (dataSource: DataSourceProtocol) {
        self.dataSource = dataSource
        
        // subscribe for changes in deleted items list
        delegateIndex = dataSource.addDelegate(delegate: self)
    }
    
    /**
     * Called to get title.
     */
    func getTitle() -> String {
        return "Media List"
    }
    
    /**
     * Makes api call to get the list.
     */
    func load() {
        
        if !CheckInternet.connection() {
            viewDelegate?.showAlert(alertTitle: "Warning", alertMessage: "You are not connected to the internet!", buttonTitle: "Retry")
        }
    }
    
    /**
     * Called when user clicks button in alert.
     */
    func didAlertButtonClick() {
        
        load()
    }
    
    /**
     * Called when a row of the media list is selected.
     * @param index: index of the selected section.
     */
    func didRowSelect(index: Int) {
        
        list[index].isSelected = true
        dataSource.saveVisitedItem(id: list[index].media.trackId ?? 0)
        viewDelegate?.showList(indexToUpdate: index, indexToDelete: -1)
        viewDelegate?.openPage(media: list[index].media)
    }

    /**
     * Called when cell pressed long.
     * @param index: index of the selected row.
     * @return MediaDetailViewController: controller to show
     */
    func didPressLong(index: Int) -> UIViewController {
        
        return MediaDetailBuilder.make(with: list[index].media)
    }
    
    /**
     * Called when input of search changed.
     * @param text: new search string.
     */
    func didSearchInputChange(text: String = "") {
        
        searchText = text
        if text.isEmpty {
            list = []
            viewDelegate?.showList(indexToUpdate: -1, indexToDelete: -1)
            viewDelegate?.showHideMessage(isHidden: false)
        } else {
            
            // cancel the previous request
            searchTimer?.invalidate()
            
            // wait for 0.3 seconds to fetch list
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { (timer) in
                self.fetchList()
            })
        }
    }
    
    /**
     * Called when deleted item status changed.
     * @param id: deleted media track id.
     */
    func didChangeDeletedItemStatus(id: Int) {
        
        // find media index from given id
        let index = list.firstIndex { (item) -> Bool in
            return item.media.trackId == id
        }
        
        // update media in the list and show list
        if  index != nil && index! > -1 {
            list.remove(at: index!)
            viewDelegate?.showList(indexToUpdate: -1, indexToDelete: index!)
        }
    }
    
    func didMediaFilterOptionSelect(option: String) {
        
        // if user selects same option, no need to fetch the list
        if selectedOption == option {
            return
        }
        
        selectedOption = option
        fetchList()
    }
    
    func didFilterButtonClick() {
       
        viewDelegate?.showMediaFilter(options: [
            MediaFilterOption(filterName: "All", value: "all", isSelected: selectedOption == "all"),
            MediaFilterOption(filterName: "Movie", value: "movie", isSelected: selectedOption == "movie"),
            MediaFilterOption(filterName: "Music", value: "music", isSelected: selectedOption == "music"),
            MediaFilterOption(filterName: "Podcast", value: "podcast", isSelected: selectedOption == "podcast")
            ])
    }
    
    func fetchList() {
        
        Observable.zip(
            // get selected item list
            dataSource.getVisitedItemList(),
            
            // get deleted item list
            dataSource.getDeletedItemList(),
            
            // get media list
            dataSource.getSearchResult(term: searchText, country: "US", media: selectedOption, limit: limit),
            
            // consume the result of two async actions
            resultSelector: { selectedItemList, deletedItemList, response in
                self.list = []
                response.results.forEach({ item in
                    if deletedItemList.firstIndex(of: item.trackId ?? 0) == nil {
                        self.list.append(MediaListCellViewModel(
                            isSelected: selectedItemList.firstIndex(of: item.trackId ?? 0) != nil,
                            media: item
                        ))
                    }
                })
        }).observeOn(MainScheduler.instance)
            .subscribe(onError: {_ in
                self.viewDelegate?.showAlert(alertTitle: "Error", alertMessage: "Fetching list failed!", buttonTitle: "Retry")
            }, onCompleted: {
                self.viewDelegate?.showList(indexToUpdate: -1, indexToDelete: -1)
                self.viewDelegate?.showHideMessage(isHidden: true)
            }).disposed(by: self.disposeBag)
    }
    
    deinit {
        
        // unsubscribe for changes in deleted items list
        dataSource.removeDelegate(index: delegateIndex)
    }
}
