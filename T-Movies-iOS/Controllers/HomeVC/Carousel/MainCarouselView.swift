//
//  MainCarouselView.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import ToosieSlide
import UIKit
import Combine

class MainCarouselView: UIView {
    private let reuseIdentifier = "CustomCarouselCell"

    let viewModel = HomeViewModel()
    var cancellable: Set<AnyCancellable> = []
    
    var initListMovies :[Result] = []
    
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
      viewModel.getPopularMoviesResponse()
      
      viewModel.$popularMovieResponse.sink(receiveValue: { movieResponse in
          if movieResponse?.results.isEmpty == false {
              //print("items : \(movieResponse!)")
              self.initListMovies = movieResponse?.results ?? [Result]()
              
              // init collection
              self.collection.dataSource = self
              self.collection.delegate = self
          }

      }).store(in: &cancellable)
    
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
      initListMovies.count
  }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCarouselCell.identifier, for: indexPath) as? CustomCarouselCell else { fatalError("can't dequeue CustomCell") }
        
        cell.setImage(initListMovies[indexPath.item].posterPath)
        cell.setTitle(initListMovies[indexPath.item].title)
        cell.setRateValue(String(Double(round(10 * Double(initListMovies[indexPath.item].voteAverage)) / 10)) )

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let movieDetailsVC = MovieDetailsVC()
        movieDetailsVC.movieInfo = initListMovies[indexPath.row]
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // get the parent VienComtroller to have the ability to navigate
            // in case of creating an instance of HomeVC() that will not work
            // because it's a new instance and we alreeady have an instance of homeVC that runs
            if let navigationController = UIApplication.getTopViewController()?.navigationController {
              navigationController.pushViewController(movieDetailsVC, animated: true)
            }
        }
        
        
    }
}

extension MainCarouselView: UICollectionViewDelegateCarouselLayout {
    func collectionView(_ collectionView: UICollectionView, willDisplayCellAt cellIndex: CellIndex) {
        print("Will Display Cell at \(cellIndex)")
    }
}
