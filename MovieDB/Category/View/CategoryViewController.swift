//
//  CategoryViewController.swift
//  MovieDB
//
//  Created by MacBook on 04/01/22.
//

import UIKit

class CategoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    private let presenter = CategoryPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.bind(to: self)
        presenter.getCategories()
        setupTableView()
        
    }
    
    
}

extension CategoryViewController:CategoryViewProtocol{
    func showAlert() {
        let alert = UIAlertController(title: "Something Went Wrong", message: "The Data Can't Be Loaded", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.presenter.getCategories()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func setupTableView(){
        let uiNib = UINib(nibName: String(describing: CategoryCell.self), bundle: nil)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(uiNib, forCellReuseIdentifier: String(describing: CategoryCell.self))
        self.tableView.isScrollEnabled = false

    }
    
    func setTableViewHeight() {
        self.heightConstraint.constant = CGFloat(Float(presenter.numberOfItems) * 70.0)
    }
    
    func updateCategories() {
        tableView.reloadData()
    }
    
    
}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CategoryCell.self), for: indexPath) as! CategoryCell
        let category = presenter.genreDataSource[indexPath.row]
        cell.categoryLabel.text = category.name
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieListViewController(nibName: "MovieListViewController", bundle: nil)
        presenter.selectCategory(at: indexPath.row)
        if let category = presenter.selectedCategory{
            vc.setup(with: category)
        }
        self.navigationController!.pushViewController(vc, animated: true)
    }



}

