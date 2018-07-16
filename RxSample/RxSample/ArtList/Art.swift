//
//  Art.swift
//  RxSample
//
//  Created by admin on 2018/07/08.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxDataSources

struct Art {
    let name: String
    let taste: String
    let imageId: String
    var image: UIImage?
    
    init(name: String, taste: String, imageId: String) {
        self.name = name
        self.taste = taste
        self.imageId = imageId
        self.image = UIImage(named: imageId)
    }
}

extension Art: IdentifiableType {
    typealias Identity = String
    var identity: Identity { return imageId }
}
