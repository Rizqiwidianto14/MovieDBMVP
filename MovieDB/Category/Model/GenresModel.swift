//
//  CategoryModel.swift
//  MovieDB
//
//  Created by MacBook on 04/01/22.
//

import ObjectMapper

class Genres: Mappable{
    internal var id: Int?
    internal var name: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
