//
//  EndPoints.swift
//  MovieDB
//
//  Created by MacBook on 04/01/22.
//

import Moya


enum MovieDBApi {
    case categories
    case movieListByGenres(page:Int, genreId: Int)
    case movieDetail(movieId: Int)
    case movieTrailer(movieId: Int)
}

extension MovieDBApi: TargetType{
    var baseURL: URL {
        guard let url = URL(string: Constant.baseUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .categories:
            return "genre/movie/list"
        case .movieListByGenres:
            return "discover/movie"
        case .movieDetail(let movieId):
            return "movie/\(movieId)"
        case .movieTrailer(let movieId):
            return "movie/\(movieId)/videos"
        }
    }
    
    var method: Moya.Method {
        return Moya.Method.get
    }
    
    var task: Task {
        switch self {
        case .categories:
            return .requestParameters(parameters: ["api_key":  Constant.apiKey], encoding: URLEncoding.queryString)
        case .movieListByGenres(page: let page, genreId: let genreId):
            return .requestParameters(parameters: ["page":page, "api_key":  Constant.apiKey, "with_genres": genreId], encoding: URLEncoding.queryString)
        case .movieDetail:
            return .requestParameters(parameters: ["api_key":  Constant.apiKey], encoding: URLEncoding.queryString)
        case .movieTrailer:
            return .requestParameters(parameters: ["api_key":  Constant.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data{
        return Data()
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
