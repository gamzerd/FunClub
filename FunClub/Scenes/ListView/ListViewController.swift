//
//  ListViewController.swift
//  FunClub
//
//  Created by Gamze on 3/19/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import UIKit
import RxSwift

final class ListViewController: UIViewController {
   
    let dataSource = ItunesDataSource()

    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        dataSource.getSearchResult(term: "lost", country: "US", media: "all")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { response in
                print(response)
            }, onError: {_ in
                print("error")
            }, onCompleted: {
                print("completed")
            }).disposed(by: self.disposeBag)
        
    }
    
}
