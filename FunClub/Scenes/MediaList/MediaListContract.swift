//
//  MediaListContract.swift
//  FunClub
//
//  Created by Gamze on 3/20/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

protocol MediaListViewModelProtocol: class {
    
    var viewDelegate: MediaListViewProtocol? { get set }
    
    var list: [MediaListCellViewModel] { get set }
    
    func load()
    
    func getTitle() -> String
    
    func didRowSelect(index: Int)
    
    func didPressLong(index: Int) -> UIViewController
        
    func didAlertButtonClick()
    
    func didSearchInputChange(text: String)
    
    func didMediaFilterOptionSelect(option: String)
    
    func didFilterButtonClick()
}

protocol MediaListViewProtocol: class {
    
    func showList(indexToUpdate: Int, indexToDelete: Int)
    
    func showHideMessage(isHidden: Bool)
    
    func showMediaFilter(options: [MediaFilterOption])
    
    func openPage(media: Media)
    
    func showAlert(alertTitle: String, alertMessage: String, buttonTitle: String?)
    
}
