//
//  MovieListPresenter.swift
//  MovieDB
//
//  Created by MacBook on 13/01/22.
//

import Foundation

class MovieListPresenter{
    var networkManager = NetworkManager()
    var moviesDataSource: [Movies] = []
    var selectedMovies: Movies?
    var category: Genres!
    var page: Int = 1
    
    private weak var view: MovieListViewProtocol!

    var numberOfItems:Int{
        return moviesDataSource.count
    }
    
    var isPaginating: Bool{
        return networkManager.isPaginating
    }
    
    func selectMovie(at index: Int){
        selectedMovies = moviesDataSource[index]
    }
    
}

extension MovieListPresenter: MovieListPresenterProtocol{
    func bind(to view: MovieListViewProtocol, category: Genres) {
        self.view = view
        self.category = category
    }
    
    func getMovies(pagination: Bool, page: Int, genreId: Int) {
        networkManager.fetchMoviesByCategory(pagination: pagination, page: page, genreId: genreId) { (result) in
            if result.count > 0 {
                DispatchQueue.main.async {
                    self.moviesDataSource.append(contentsOf: result)
                    self.view.setupInfiniteScrollHeight()
                    self.view.indicatorView(animate: true)
                    self.view.updateMovies()
                    
                }
            }
        } onFailed: { (error) in
            print(error)
        }
    }
    
    
}
