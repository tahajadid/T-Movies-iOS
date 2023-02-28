//
//  HomeVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 27/2/2023.
//

import ToosieSlide
import UIKit

class HomeVC: UIViewController {

    private let reuseIdentifier = "CustomCarouselCell"
    
    private let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    

}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      collectionView.dequeueReusableCell(withReuseIdentifier: CustomCarouselCell.identifier, for: indexPath) as? CustomCarouselCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplayCellAt cellIndex: CellIndex) {
      print("Will Display Cell at \(cellIndex)")
    }
}
