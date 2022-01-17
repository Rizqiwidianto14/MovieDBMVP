//
//  CategoryProtocol.swift
//  MovieDB
//
//  Created by MacBook on 13/01/22.
//

import Foundation

protocol CategoryPresenterProtocol{
    var genreDataSource: [Genres] {get set}
    func selectCategory(at index: Int)
    func bind(to view: CategoryViewProtocol)
    func getCategories()
}

protocol CategoryViewProtocol: AnyObject{
    func updateCategories()
    func setTableViewHeight()
    func setupTableView()
    func showAlert()
}
