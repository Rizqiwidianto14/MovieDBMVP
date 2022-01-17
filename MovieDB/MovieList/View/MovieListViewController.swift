//
//  MovieListViewController.swift
//  MovieDB
//
//  Created by MacBook on 06/01/22.
//

import UIKit

class MovieListViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let presenter = MovieListPresenter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
        guard let presenterId = presenter.category.id else {
            return
        }
        presenter.getMovies(pagination: true, page: presenter.page, genreId: presenterId)
        setupCollectionView()
        
    }

}

extension MovieListViewController: MovieListViewProtocol{
    func showAlert() {
        let alert = UIAlertController(title: "Something Went Wrong", message: "The Data Can't Be Loaded", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            guard let presenterId = self.presenter.category.id else {
                return
            }
            self.presenter.getMovies(pagination: true, page: self.presenter.page, genreId: presenterId)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setup(with category: Genres){
        presenter.bind(to: self, category: category)
    }
    
    func setupCollectionView(){
        let uiNib = UINib(nibName: String(describing: MovieListCell.self), bundle: nil)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(uiNib, forCellWithReuseIdentifier: String(describing: MovieListCell.self))
        self.collectionView.isScrollEnabled = false
        
    }
    func setupInfiniteScrollHeight() {
        self.heightConstrain.constant = CGFloat(Float(presenter.numberOfItems/3) * Float(UIScreen.main.bounds.width/2))
    }
    
    func updateMovies() {
        self.collectionView.reloadData()
    }
    
    func indicatorView(animate: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: animate ? 50 : 0, right: 0)
            _ = animate ? self?.indicatorView.startAnimating() : self?.indicatorView.stopAnimating()
            self?.indicatorView.isHidden = true

        }
    }
    
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieListCell.self), for: indexPath) as! MovieListCell
        let movie = presenter.moviesDataSource[indexPath.row]
        cell.showData(movie: movie)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((collectionView.frame.size.width / 3) - 10), height: UIScreen.main.bounds.width/2)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        presenter.selectMovie(at: indexPath.row)
        if let movie = presenter.selectedMovies{
            vc.setup(with: movie)
        }
        self.navigationController!.pushViewController(vc, animated: true)
    }
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollHeight = scrollView.frame.size.height
        
        if offsetY >= contentHeight - scrollHeight{
            indicatorView.isHidden = false
            guard !presenter.isPaginating else{
                return
            }
            presenter.page+=1
            indicatorView(animate: true)
            guard let presenterId = presenter.category.id else {
                return
            }
            presenter.getMovies(pagination: true, page: presenter.page, genreId: presenterId)
        }
    }
}
