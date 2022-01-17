//
//  MovieModel.swift
//  MovieDB
//
//  Created by MacBook on 06/01/22.
//

import Foundation
import ObjectMapper


class Movies: Mappable{
    internal var posterImage: String?
    internal var title: String?
    internal var id: Int?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        posterImage <- map["poster_path"]
        title <- map["title"]
        id <- map["id"]
    }
}
