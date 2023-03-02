//
//  SingleMovieCell.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 2/3/2023.
//

import UIKit

class SingleMovieCell: UICollectionViewCell {

    @IBOutlet weak var movieBg: UIImageView!
    @IBOutlet weak var moviPoster: UIImageView!
    @IBOutlet weak var favouriteImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        movieBg.layer.cornerRadius = 16
        moviPoster.layer.cornerRadius = 16

    }

}
