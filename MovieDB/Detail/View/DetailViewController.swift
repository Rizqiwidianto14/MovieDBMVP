//
//  DetailViewController.swift
//  MovieDB
//
//  Created by MacBook on 08/01/22.
//

import UIKit
import Kingfisher
import youtube_ios_player_helper


class DetailViewController: UIViewController {
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playerView: YTPlayerView!

    private let presenter = DetailPresenter()

    override func viewWillAppear(_ animated: Bool) {
       setupNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenterId = presenter.movies.id else {
            return
        }
        presenter.getMovieDetail(movieId: presenterId)
        presenter.getTrailer(movieId: presenterId)

    }

}

extension DetailViewController: DetailViewProtocol{
    func showAlert() {
        let alert = UIAlertController(title: "Something Went Wrong", message: "The Data Can't Be Loaded", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            guard let presenterId = self.presenter.movies.id else {
                return
            }
            self.presenter.getMovieDetail(movieId: presenterId)
            self.presenter.getTrailer(movieId: presenterId)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupNavBar() {
        scrollView?.contentInset = UIEdgeInsets(top: -100, left: 0, bottom: 0, right: 0)
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem?.tintColor = UIColor.white
    }
    
    func updateTrailer(path: String) {
        DispatchQueue.main.async {
            self.playerView.load(withVideoId: path, playerVars: ["playsinline":1])

        }
    }
    
    func updateView(title: String, moviePoster: String, movieBackdrop: String, overview: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = title
            self.descriptionLabel.text = overview
            self.backdropImage.kf.setImage(with:URL(string: Constant.imageBaseUrl+"/original"+movieBackdrop))
            self.posterImage.kf.setImage(with:URL(string: Constant.imageBaseUrl+"/original"+moviePoster))
        }
    }


    func setup(with movies: Movies) {
        presenter.bind(to: self, movies: movies)
    }
    
    
}
