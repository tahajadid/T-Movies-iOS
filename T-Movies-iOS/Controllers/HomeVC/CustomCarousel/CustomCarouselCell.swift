//
//  CustomCarouselCell.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 27/2/2023.
//

import UIKit

class CustomCarouselCell: UICollectionViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rating: UILabel!
    
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
        imageView.layer.cornerRadius = 12


    }

}
