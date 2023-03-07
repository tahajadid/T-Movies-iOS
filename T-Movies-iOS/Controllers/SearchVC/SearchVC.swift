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

        initCategoryCollectionView()
        configureUI()
        
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
    

    func configureUI() {
        
        searchView.layer.cornerRadius = 8
        
        viewModel.getMoviesResponse()
        viewModel.$movieResponse.sink(receiveValue: { movieResponse in
            if movieResponse?.results.isEmpty == false {
                //print("items : \(movieResponse!)")
                self.initListMovies = movieResponse?.results ?? [Result]()
                self.initMoviesCollectionView()
            }

        }).store(in: &cancellable)

        
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    //Calls this function when the tap is recognized.
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    private func initMoviesCollectionView() {
        // init Movies collection View
        moviesCollectionFlow.collectionView?.delegate = self
        let nib = UINib(nibName: "SingleMovieCell", bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: "SingleMovieCell")
        moviesCollectionView.dataSource = self
        
    }
    
    private func initCategoryCollectionView() {
        // init Categories collection View
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if(collectionView.isEqual(self.moviesCollectionView)){
            let movieDetailsVC = MovieDetailsVC()
            movieDetailsVC.movieInfo = initListMovies[indexPath.row]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let navigationController = self.navigationController {
                  navigationController.pushViewController(movieDetailsVC, animated: true)
                }
            }
        } else {
            self.setSelectedItem(self.categoryList[indexPath.row])
            collectionView.reloadData()
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
    
    // invoked when we click on category cell
    func setSelectedItem(_ categoryOptionItem: CategoryOptionItem) {
        for item in self.categoryList {
            if(categoryOptionItem.id == item.id){
                self.categoryList[item.id!].isSelected = true
            }else {
                self.categoryList[item.id!].isSelected = false
            }
            
        }
    }

}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         if(collectionView.isEqual(self.moviesCollectionView)){
             return CGSize(width: self.view.frame.width/3 - 12, height: self.view.frame.height/3 - 60)
         } else {
             return CGSize(width: self.view.frame.width/3 - 12, height: 50)
         }
    }
}

