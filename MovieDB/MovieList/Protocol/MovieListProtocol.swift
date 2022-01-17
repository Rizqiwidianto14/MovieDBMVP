//
//  MovieListProtocol.swift
//  MovieDB
//
//  Created by MacBook on 13/01/22.
//

import Foundation

protocol MovieListPresenterProtocol{
    var moviesDataSource: [Movies] {get set}
    func bind(to view: MovieListViewProtocol, category: Genres)
    func getMovies(pagination: Bool, page: Int, genreId: Int)
}

protocol MovieListViewProtocol: AnyObject{
    func updateMovies()
    func indicatorView(animate: Bool)
    func setupInfiniteScrollHeight()
    func setupCollectionView()
    func setup(with category: Genres)
    func showAlert()
}
