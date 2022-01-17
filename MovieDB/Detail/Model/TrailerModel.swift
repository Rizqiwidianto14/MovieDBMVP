//
//  TrailerModel.swift
//  MovieDB
//
//  Created by MacBook on 08/01/22.
//

import Foundation
import ObjectMapper

class TrailerModel: Mappable{
    internal var key: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        key <- map["key"]
    }
}

