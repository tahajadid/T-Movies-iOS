//
//  SearchVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import UIKit
import Combine

class SearchVC: UIViewController {

    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionFlow: UICollectionViewFlowLayout!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionFlow: UICollectionViewFlowLayout!
    
    @IBOutlet weak var searchView: UIView!
    
    let viewModel = HomeViewModel()
    var cancellable: Set<AnyCancellable> = []
    var initListMovies :[Result] = []
    private let categoryReuseIdentifier = "CategoryItemCell"
    
    var categoryList: [CategoryOptionItem] = Constants.categoryList

    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad -----")

        searchView.layer.cornerRadius = 8
        //initCollectionView()
        
        viewModel.getMoviesResponse()

        
        viewModel.$movieResponse.sink(receiveValue: { movieResponse in
            if movieResponse?.results.isEmpty == false {
                //print("items : \(movieResponse!)")
                self.initListMovies = movieResponse?.results ?? [Result]()
                
                self.initCollectionView()
            }
            print("items -----")

        }).store(in: &cancellable)
        // Do any additional setup after loading the view.
    }

    
    // Hide navigationBar on the Top
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        print("viewWillAppear -----")

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    private func initCollectionView() {
        moviesCollectionFlow.collectionView?.delegate = self
        let nib = UINib(nibName: "SingleMovieCell", bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: "SingleMovieCell")
        moviesCollectionView.dataSource = self
        
        categoryCollectionFlow.collectionView?.delegate = self
        let nibCategory = UINib(nibName: categoryReuseIdentifier, bundle: nil)
        categoryCollectionView.register(nibCategory, forCellWithReuseIdentifier: categoryReuseIdentifier)
        categoryCollectionView.dataSource = self
        
    }
    
    func loading (show : Bool) {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
       if ( show == false)
        {
           dismiss(animated: false, completion: nil)
        }
    }

}

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.isEqual(self.moviesCollectionView)){
            return initListMovies.count
        }else{
            return categoryList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView.isEqual(self.moviesCollectionView)){
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SingleMovieCell", for: indexPath) as? SingleMovieCell else {
                fatalError("can't dequeue CustomCell")
            }
            cell.startSpinner()
            cell.setImage(initListMovies[indexPath.item].posterPath)
            cell.favouriteButton.addTarget(self, action: #selector(customCellButtonTapped), for: .touchUpInside)
            if(initListMovies[indexPath.row].isFavourite == true){
                cell.favouriteButton.setImage(UIImage(named: "favourite_fill"), for: .normal)
            }
            cell.hideSpinner()

            return cell
            
        }else{
            guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryReuseIdentifier, for: indexPath) as? CategoryItemCell else {fatalError("can't dequeue CustomCell")}
            
            categoryCell.categoryTitle.text = categoryList[indexPath.item].title
            categoryCell.adaptBackground(categoryList[indexPath.item].isSelected ?? false)
            
            return categoryCell
        }
    
    }
    
    // invoked when we click on like image
    @objc func customCellButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: moviesCollectionView)
        guard let indexPath = moviesCollectionView.indexPathForItem(at: point)  else { return }
        print(indexPath.row)

        initListMovies[indexPath.row].isFavourite = !initListMovies[indexPath.row].isFavourite
        
        moviesCollectionView.reloadData()
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if(collectionView.isEqual(self.moviesCollectionView)){
            let movieDetailsVC = MovieDetailsVC()
            movieDetailsVC.movieInfo = initListMovies[indexPath.row]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let navigationController = self.navigationController {
                  navigationController.pushViewController(movieDetailsVC, animated: true)
                }
            }
        }
    }

}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/3 - 12, height: self.view.frame.height/3 - 60)
    }
}

