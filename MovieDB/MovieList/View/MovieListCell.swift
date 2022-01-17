//
//  MovieListCell.swift
//  MovieDB
//
//  Created by MacBook on 06/01/22.
//

import UIKit
import Kingfisher

class MovieListCell: UICollectionViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func showData(movie: Movies) {
        guard let posterPath = movie.posterImage else {return}
        let url = URL(string: Constant.imageBaseUrl+"/w500"+posterPath)
        moviePoster.kf.setImage(with: url)
    }
    
    

}
