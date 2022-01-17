//
//  DetailViewPresenter.swift
//  MovieDB
//
//  Created by MacBook on 13/01/22.
//

import Foundation


class DetailPresenter{
    var networkManager = NetworkManager()
    var movie:Movie!
    var movies: Movies!
    var trailerDataSource: [TrailerModel] = []
    
    private weak var view: DetailViewProtocol!

}

extension DetailPresenter: DetailPresenterProtocol{
    func getTrailer(movieId: Int) {
        networkManager.fetchTrailer(id: movieId){ (result) in
            if result.count > 0 {
                self.trailerDataSource = result
                guard let path = self.trailerDataSource[0].key else {return}
                self.view.updateTrailer(path: path)

            }

        } onFailed: { (error) in
            print(error)
        }
    }
    

    func bind(to view: DetailViewProtocol, movies: Movies) {
        self.view = view
        self.movies = movies
    }
    
    func getMovieDetail(movieId: Int) {
        networkManager.fetchMovieDetail(id: movieId) { (result) in
            guard let movieTitle = result.title, let moviePoster = result.posterPath, let movieBackdrop = result.backdropPath, let overview = result.overview else {return}
            self.view.updateView(title: movieTitle, moviePoster: moviePoster, movieBackdrop: movieBackdrop, overview: overview)
            
        } onFailed: { (error) in
            print(error)
        }
        
    }
    
    
}

