//
//  ItunesUtility.swift
//  FunClub
//
//  Created by Gamze on 3/23/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

class ItunesUtility {
    
    static func getProperImageUrl(url: String, size: Int) -> String {
        
        return url.replacingOccurrences(of: "100", with: String(size))
    }
}
