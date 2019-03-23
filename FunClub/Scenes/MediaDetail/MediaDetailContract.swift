//
//  MediaDetailContract.swift
//  FunClub
//
//  Created by Gamze on 3/23/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

protocol MediaDetailViewModelProtocol: class{
    
    var media: Media { get set }
    
    func getTitle() -> String
        
}
