//
//  NetworkManager.swift
//  MovieDB
//
//  Created by MacBook on 04/01/22.
//

import Moya
import Moya_ObjectMapper

protocol Network {
    associatedtype T: TargetType
    var provider: MoyaProvider<T> { get }
}


class NetworkManager: Network {
    let provider = MoyaProvider<MovieDBApi>()
    var isPaginating = false

    
    func fetchCategory(completion: @escaping ([Genres]) -> (),onFailed: ((String) -> Void)?){
        provider.request(.categories) { result in
            switch result{
            case let .success(response):
                do{
                    let results = try response.mapArray(Genres.self, atKeyPath: "genres")
                    completion(results)
                } catch let error {
                    let err = error as NSError
                    onFailed?(err.domain)
                }
            case let .failure(error):
                let err = error as NSError
                onFailed?(err.domain)

            }
        }
    }
    
    func fetchMoviesByCategory(pagination: Bool, page: Int, genreId: Int, completion: @escaping ([Movies]) -> (),onFailed: ((String) -> Void)?){
        if pagination{
            isPaginating = true
        }
        provider.request(.movieListByGenres(page: page, genreId: genreId)) { result in
            switch result{
            case let .success(response):
                do{
                    let results = try response.mapArray(Movies.self, atKeyPath: "results")
                    completion(results)
                    if pagination{
                        self.isPaginating = false
                    }
                } catch let error {
                    let err = error as NSError
                    onFailed?(err.domain)
                    
                }
            case let .failure(error):
                let err = error as NSError
                onFailed?(err.domain)
            }
        }
    }
    
    func fetchMovieDetail(id: Int, completion: @escaping (Movie)->(), onFailed: ((String) -> Void)?){
        provider.request(.movieDetail(movieId: id)) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try response.mapObject(Movie.self)
                    completion(results)
                } catch let error {
                    let err = error as NSError
                    onFailed?(err.domain)
                }
            case let .failure(error):
                let err = error as NSError
                onFailed?(err.domain)
            }

        }
        }
    
    func fetchTrailer(id: Int, completion: @escaping ([TrailerModel]) -> (),onFailed: ((String) -> Void)?){
        
        provider.request(.movieTrailer(movieId: id)) { result in
            switch result{
            case let .success(response):
                do{
                    let results = try response.mapArray(TrailerModel.self, atKeyPath: "results")
                    completion(results)
                } catch let error {
                    let err = error as NSError
                    onFailed?(err.domain)
                    
                }
            case let .failure(error):
                let err = error as NSError
                onFailed?(err.domain)
            }
        }
    }
}
