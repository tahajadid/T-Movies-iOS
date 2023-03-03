//
//  SingleMovieCell.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 2/3/2023.
//

import UIKit
import SDWebImage

class SingleMovieCell: UICollectionViewCell {

    @IBOutlet weak var movieBg: UIImageView!
    @IBOutlet weak var moviPoster: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        movieBg.layer.cornerRadius = 16
        moviPoster.layer.cornerRadius = 16
        
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
    }
    
    @objc func changeFavovuriteIcon(_ sender:UITapGestureRecognizer){
        // do other task
        favouriteButton.setImage(UIImage(named: "favourite_fill"), for: .normal)
    }


}
