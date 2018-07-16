//
//  PageControlViewModel.swift
//  RxSample
//
//  Created by admin on 2018/07/09.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PageControlViewModel {
    private let dataSource = [
        UIImage(named: "sample002"),
        UIImage(named: "sample005"),
        UIImage(named: "sample008"),
        UIImage(named: "sample011"),
    ]
    
    func getData() -> Observable<[UIImage?]> {
        let obsDataSource = Observable.just(dataSource)
        return obsDataSource
    }
}
