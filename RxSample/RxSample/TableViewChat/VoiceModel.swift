//
//  VoiceModel.swift
//  RxSample
//
//  Created by admin on 2018/07/06.
//  Copyright © 2018年 admin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class VoiceModel {
    let itemsEvent = Variable<[VoiceItem]>([])
    var items: Observable<[VoiceItem]> {
        return itemsEvent.asObservable()
    }
    
    var rx_items: AnyObserver<String> {
        return AnyObserver<String>(eventHandler: {(e) in
            self.addItem(item: VoiceItem(user: "A", message: e.element!))
            self.addItem(item: VoiceItem(user: "B", message: e.element! + "ですか！スギョイ！"))
        })
    }
    
    init(){
    }
    
    func addItem(item: VoiceItem) {
        itemsEvent.value.append(item)
    }
}
