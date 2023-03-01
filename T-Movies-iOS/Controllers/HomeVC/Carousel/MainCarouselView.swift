//
//  MainCarouselView.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import ToosieSlide
import UIKit

class MainCarouselView: UIView {
    private let reuseIdentifier = "CustomCarouselCell"

  // MARK: - UIElements
  
  //private let button = UIButton()
  
  lazy var collection: UICollectionView = {
    let carouselFlow = UICollectionViewCarouselLayout()
    carouselFlow.itemSize = CGSize(width: CustomCarouselCell.width, height: CustomCarouselCell.height)

    carouselFlow.minimumLineSpacing = 0
        
    let collection = UICollectionView(collectionViewCarouselLayout: carouselFlow)
    
    let nib = UINib(nibName: reuseIdentifier, bundle: nil)
    collection.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

    //collection.register(CustomCarouselCell.self, forCellWithReuseIdentifier: CustomCarouselCell.identifier)
    return collection
  }()
  
  // MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
      
    configure()
    style()
    update()
    layout()
    
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    configure()
    style()
    update()
    layout()
      
  }
  
  // MARK: - CSUL
  
  func configure() {
    addSubview(collection)
    
    collection.dataSource = self
    collection.delegate = self
    
  }
  
  func style() {
      collection.showsHorizontalScrollIndicator = false
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
          self.collection.scrollToCell(at: 2)
      }
  }
  
  func update() {}
  
  func layout() {
    collection.translatesAutoresizingMaskIntoConstraints = false
    collection.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    collection.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    collection.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    collection.heightAnchor.constraint(equalToConstant: 400).isActive = true
    collection.backgroundColor = UIColor(named: "background_color")
      
  }
}

// MARK: - Action

extension MainCarouselView {
  @objc func scrollToCell() {
    let randomInt = Int.random(in: 0..<8)
    print("scroll to cell \(randomInt)")
    collection.scrollToCell(at: randomInt)
  }
}

// MARK: - Data Source

extension MainCarouselView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    8
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    collectionView.dequeueReusableCell(withReuseIdentifier: CustomCarouselCell.identifier, for: indexPath) as? CustomCarouselCell ?? UICollectionViewCell()
  }
}

extension MainCarouselView: UICollectionViewDelegateCarouselLayout {
  func collectionView(_ collectionView: UICollectionView, willDisplayCellAt cellIndex: CellIndex) {
    print("Will Display Cell at \(cellIndex)")
  }
}
