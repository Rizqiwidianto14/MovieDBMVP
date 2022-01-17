//
//  MovieModel.swift
//  MovieDB
//
//  Created by MacBook on 08/01/22.
//

import Foundation
import ObjectMapper



class Movie: Mappable{
    internal var backdropPath: String?
    internal var title: String?
    internal var id: Int?
    internal var overview: String?
    internal var posterPath: String?    
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        backdropPath <- map["backdrop_path"]
        title <- map["title"]
        id <- map["id"]
        overview <- map["overview"]
        posterPath <- map["poster_path"]
        
    }
}
