//
//  CategoryItemCell.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 7/3/2023.
//

import UIKit

class CategoryItemCell: UICollectionViewCell {

    @IBOutlet weak var categoryBackground: UIView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryBackground.layer.cornerRadius = 8
        categoryBackground.layer.masksToBounds = true

    }
    
    
    func adaptBackground(_ isSelected: Bool) {
        if isSelected {
            categoryBackground.backgroundColor = UIColor(named: "selected_categorie")
            categoryTitle.textColor = .white
        } else {
            categoryBackground.backgroundColor = UIColor(named: "unselected_categorie")
            categoryTitle.textColor = UIColor(named: "background_color")
        }
    }

}
