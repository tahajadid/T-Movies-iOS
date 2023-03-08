//
//  SingleMovieCell.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 2/3/2023.
//

import UIKit
import SDWebImage
import UIView_Shimmer

class SingleMovieCell: UICollectionViewCell, ShimmeringViewProtocol {

    @IBOutlet weak var movieBg: UIImageView!
    @IBOutlet weak var moviPoster: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var shimmeringAnimatedItems: [UIView] {
        [
            movieBg,
            moviPoster,
            favouriteButton,
            spinner
        ]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        movieBg.layer.cornerRadius = 16
        moviPoster.layer.cornerRadius = 16
        
        spinner.layer.cornerRadius = 8
        
        movieBg.isHidden = true
        startSpinner()
    }
    
    override func prepareForReuse() {
        favouriteButton.setImage(UIImage(named: "favourite"), for: .normal)
        super.prepareForReuse()
    }
    
    func setImage(_ pathWallpapaer: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(pathWallpapaer)") else {
            return
        }
        moviPoster.sd_setImage(with: url, completed: nil)
        movieBg.isHidden = false

    }
    
    @objc func changeFavovuriteIcon(_ sender:UITapGestureRecognizer){
        // do other task
        favouriteButton.setImage(UIImage(named: "favourite_fill"), for: .normal)
    }

    func startSpinner() {
        spinner.startAnimating()
        print("Show spinner")
    }
    
    func hideSpinner() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        print("// Hide spinner")

    }
}
