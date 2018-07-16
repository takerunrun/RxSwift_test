//
//  Repository.swift
//  RxSample
//
//  Created by admin on 2018/07/08.
//  Copyright © 2018年 admin. All rights reserved.
//

import ObjectMapper

class Repository: Mappable {
    var identifier: Int!
    var html_url: String!
    var name: String!
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        identifier <- map["id"]
        html_url <- map["html_url"]
        name <- map["name"]
    }
}


