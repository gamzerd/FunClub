//
//  ServiceProtocol.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    
    func get<E, D>(path: String, params: E, callback: @escaping (D?, Error?) -> Void) where E: Encodable, D : Decodable
    
}
