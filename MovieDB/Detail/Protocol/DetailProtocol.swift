//
//  DetailProtocol.swift
//  MovieDB
//
//  Created by MacBook on 13/01/22.
//

import Foundation

protocol DetailPresenterProtocol{
    func bind(to view: DetailViewProtocol, movies: Movies)
    func getMovieDetail(movieId: Int)
    func getTrailer(movieId: Int)
}

protocol DetailViewProtocol: AnyObject{
    func updateView(title: String, moviePoster: String, movieBackdrop: String, overview: String)
    func updateTrailer(path: String)
    func setup(with movies: Movies)
    func setupNavBar()
    func showAlert()
}
