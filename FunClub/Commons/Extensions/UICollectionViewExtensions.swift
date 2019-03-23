//
//  UICollectionViewExtensions.swift
//  FunClub
//
//  Created by Gamze on 3/22/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func register(_ cell: UICollectionViewCell.Type) {
        register(UINib(nibName: cell.identifier, bundle: nil), forCellWithReuseIdentifier: cell.identifier)
    }
}

