//
//  ArtPresenter.swift
//  RxSample
//
//  Created by admin on 2018/07/08.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ArtPresenter {
    let arts = Observable.just([
        SectionModel(model: "animal", items: [
            Art(name: "cool cat", taste: "cool", imageId: "sample001"),
            Art(name: "elephant", taste: "colorful", imageId: "sample002"),
            Art(name: "cute cat", taste: "cute", imageId: "sample003"),
            Art(name: "monkey", taste: "boss", imageId: "sample004")
        ]),
        SectionModel(model: "bicycle", items: [
            Art(name: "haward", taste: "poster", imageId: "sample017"),
            Art(name: "enjoy", taste: "poster", imageId: "sample018")
        ]),
        SectionModel(model: "brand", items: [
            Art(name: "Apple", taste: "colorful", imageId: "sample005"),
            Art(name: "california", taste: "surfing", imageId: "sample006"),
            Art(name: "adidas", taste: "Union Jack", imageId: "sample007"),
            Art(name: "pepsi", taste: "cap", imageId: "sample008")
        ]),
        SectionModel(model: "girls", items: [
            Art(name: "Audorey Hepburn", taste: "cute", imageId: "sample009"),
            Art(name: "Taylor Swift", taste: "cool", imageId: "sample010"),
            Art(name: "nobody", taste: "american comics", imageId: "sample011"),
            Art(name: "chanel", taste: "chanel", imageId: "sample012")
        ]),
        SectionModel(model: "boys", items: [
            Art(name: "snoopy", taste: "funy", imageId: "sample013"),
            Art(name: "Justin Bieber", taste: "singing", imageId: "sample014"),
            Art(name: "Dali", taste: "surrealism", imageId: "sample015"),
            Art(name: "Tupac Shakur", taste: "black", imageId: "sample016")
        ])
    ])
}
