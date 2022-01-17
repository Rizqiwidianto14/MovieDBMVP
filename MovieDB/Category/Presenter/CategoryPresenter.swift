//
//  CategoryPresenter.swift
//  MovieDB
//
//  Created by MacBook on 13/01/22.
//

import Foundation

class CategoryPresenter {
    var networkManager = NetworkManager()
    var genreDataSource: [Genres] = []
    var selectedCategory: Genres?

    private weak var view: CategoryViewProtocol!
    func selectCategory(at index: Int) {
        selectedCategory = genreDataSource[index]
    }
    
    var numberOfItems:Int{
        return genreDataSource.count
    }

}

extension CategoryPresenter: CategoryPresenterProtocol{
    
    func bind(to view: CategoryViewProtocol) {
        self.view = view
    }
    
    func getCategories() {
        networkManager.fetchCategory{ (result) in
            if result.count > 0 {
                DispatchQueue.main.async {
                    self.genreDataSource = result
                    self.view.setTableViewHeight()
                    self.view.updateCategories()
                }
            }
            
        } onFailed: { (error) in
            self.view.showAlert()
        }
    }
    
    
}
