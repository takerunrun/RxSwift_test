//
//  NumberSection.swift
//  RxSample
//
//  Created by admin on 2018/07/07.
//  Copyright © 2018年 admin. All rights reserved.
//

import Foundation
import RxDataSources

struct NumberSection {
    var header: String
    var apps: [App]
    var id: Int
    
    init(header: String, apps: [App], id: Int) {
        self.header = header
        self.apps = apps
        self.id = id
    }
}

extension NumberSection: AnimatableSectionModelType {
    typealias Item = App
    typealias Identity = String
    
    var identity: Identity {
        return header
    }
    
    var items: [Item] {
        return apps
    }
    
    init(original: NumberSection, items: [Item]) {
        self = original
        self.apps = items
    }
}

struct App {
    let id: Int
    let name: String
}

extension App: IdentifiableType, Equatable {
    typealias Identity = Int
    
    var identity: Int{
        return id
    }
}

func == (lhs: App, rhs: App) -> Bool {
    return lhs.id == rhs.id
}


