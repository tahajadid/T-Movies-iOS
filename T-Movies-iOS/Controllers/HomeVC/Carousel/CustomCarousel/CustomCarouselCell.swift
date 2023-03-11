//
//  CustomCarouselCell.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 27/2/2023.
//

import UIKit
import SDWebImage

class CustomCarouselCell: UICollectionViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var blackBackView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    /// The unique identifier of the cell.
    static let identifier = String(describing: CustomCarouselCell.self)
    /// The height of the card cell.
    static let height: CGFloat = 400
    /// The width of the card cell.
    static let width: CGFloat = 260
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backView.layer.cornerRadius = 12
        blackBackView.layer.cornerRadius = 12
        imageView.layer.cornerRadius = 12
        
        spinner.layer.cornerRadius = 8
        startSpinner()
    }
    
    func setImage(_ pathWallpapaer: String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(pathWallpapaer)") else {
            return
        }
        imageView.sd_setImage(with: url, completed: nil)
    }
    
    func setTitle(_ titleValue: String) {
        title.text = titleValue
    }
    
    func setRateValue(_ rate: String) {
        rating.text = rate
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
