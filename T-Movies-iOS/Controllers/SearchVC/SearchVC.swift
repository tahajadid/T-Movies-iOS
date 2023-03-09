//
//  SearchVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//

import UIKit
import Combine
import UIView_Shimmer

class SearchVC: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var moviesCollectionFlow: UICollectionViewFlowLayout!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionFlow: UICollectionViewFlowLayout!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - Variables
    let viewModel = SearchViewModel()
    var cancellable: Set<AnyCancellable> = []
    var initListMovies :[Result] = []
    var filteredListMovies :[Result] = []
    var categoryList: [CategoryOptionItem] = Constants.categoryList
    
    // MARK: - Constants
    private let categoryReuseIdentifier = "CategoryItemCell"
    private let movieReuseIdentifier = "SingleMovieCell"

    
    private var isLoadingMovies = true {
        didSet {
            moviesCollectionView.reloadData()
        }
    }

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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

    func configureUI() {
        
        searchView.layer.cornerRadius = 8
        
        viewModel.getLatestMoviesResponse()
        initMoviesCollectionView()

        viewModel.$latestMovieResponse.sink(receiveValue: { movieResponse in
            if movieResponse?.results.isEmpty == false {
                self.initListMovies = movieResponse?.results ?? [Result]()
                self.filteredListMovies = self.initListMovies
                // when we set the var isLoading to false
                // we invoke the reloadData method
                self.isLoadingMovies = false
            }

        }).store(in: &cancellable)
            

        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        changeClearButtonColor()

    }
    
    //Calls this function when the tap is recognized.
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK: - Search Handler
    @IBAction func searchHandler(_ sender: UITextField) {
        
        if let searachText = sender.text {
            if(searachText.isEmpty){
                filteredListMovies = initListMovies
            } else {
                filteredListMovies = initListMovies.filter{item in
                    item.title.lowercased().contains(searachText.lowercased())
                }
            }
            moviesCollectionView.reloadData()
            moviesCollectionView.reloadInputViews()

        }
    }
    
    // change ClearButton background color
    private func changeClearButtonColor() {
        if let clearButton = searchTextField.value(forKey: "_clearButton") as? UIButton {
            let templateImage = clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            clearButton.setImage(templateImage, for: .normal)
            clearButton.tintColor = UIColor(named: "label_color")
        }
    }
    
    // init Movies collection View
    private func initMoviesCollectionView() {
        moviesCollectionFlow.collectionView?.delegate = self
        let nib = UINib(nibName: movieReuseIdentifier, bundle: nil)
        moviesCollectionView.register(nib, forCellWithReuseIdentifier: movieReuseIdentifier)
        moviesCollectionView.dataSource = self
    }
    
    // init Categories collection View
    private func initCategoryCollectionView() {
        categoryCollectionFlow.collectionView?.delegate = self
        let nibCategory = UINib(nibName: categoryReuseIdentifier, bundle: nil)
        categoryCollectionView.register(nibCategory, forCellWithReuseIdentifier: categoryReuseIdentifier)
        categoryCollectionView.dataSource = self
        
    }

    func callNewMoviesList(_ category: String) {
        switch(category){
            case "Popular" :
                isLoadingMovies = true
                viewModel.getPopularMoviesResponse()
            
                viewModel.$popularMovieResponse.sink(receiveValue: { movieResponse in
                    if movieResponse?.results.isEmpty == false {
                        self.initListMovies = movieResponse?.results ?? [Result]()
                        self.filteredListMovies = self.initListMovies
                        self.isLoadingMovies = false
                        
                    }

                }).store(in: &cancellable)
            
            case "Top Rated" :
                isLoadingMovies = true
                viewModel.getTopRatedMoviesResponse()
                viewModel.$topratedMovieResponse.sink(receiveValue: { movieResponse in
                    if movieResponse?.results.isEmpty == false {
                        self.initListMovies = movieResponse?.results ?? [Result]()
                        self.filteredListMovies = self.initListMovies
                        self.isLoadingMovies = false
                    }

                }).store(in: &cancellable)
            
            case "Upcoming" :
                isLoadingMovies = true
                viewModel.getUpcomingMoviesResponse()
                viewModel.$upcomingMovieResponse.sink(receiveValue: { movieResponse in
                    if movieResponse?.results.isEmpty == false {
                        self.initListMovies = movieResponse?.results ?? [Result]()
                        self.filteredListMovies = self.initListMovies
                        self.isLoadingMovies = false
                    }

                }).store(in: &cancellable)
            
            case "Latest" :
                isLoadingMovies = true
                viewModel.getLatestMoviesResponse()
                viewModel.$latestMovieResponse.sink(receiveValue: { movieResponse in
                    if movieResponse?.results.isEmpty == false {
                        self.initListMovies = movieResponse?.results ?? [Result]()
                        self.filteredListMovies = self.initListMovies
                        self.isLoadingMovies = false
                    }

                }).store(in: &cancellable)
            
            case "Trending" :
                isLoadingMovies = true
                viewModel.getTrendingMoviesResponse()
                viewModel.$trendingMovieResponse.sink(receiveValue: { movieResponse in
                    if movieResponse?.results.isEmpty == false {
                        self.initListMovies = movieResponse?.results ?? [Result]()
                        self.filteredListMovies = self.initListMovies
                        self.isLoadingMovies = false
                    }

                }).store(in: &cancellable)
            
            default:
                print("Other")
        }
    }

}

// MARK: - SearchVC extension
extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView.isEqual(self.moviesCollectionView)){
            if(!filteredListMovies.isEmpty) {
                return filteredListMovies.count
            } else {
                return 10
            }
        }else{
            return categoryList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView.isEqual(self.moviesCollectionView)){
            print("-- -- -- -- Inside collectionView")

            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieReuseIdentifier, for: indexPath) as? SingleMovieCell else {
                fatalError("can't dequeue CustomCell")
            }
            if(!filteredListMovies.isEmpty) {
                cell.setImage(filteredListMovies[indexPath.item].posterPath)
                cell.favouriteButton.addTarget(self, action: #selector(customCellButtonTapped), for: .touchUpInside)
                if(filteredListMovies[indexPath.row].isFavourite == true){
                    cell.favouriteButton.setImage(UIImage(named: "favourite_fill"), for: .normal)
                }
            }
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
            movieDetailsVC.movieInfo = filteredListMovies[indexPath.row]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                if let navigationController = self.navigationController {
                  navigationController.pushViewController(movieDetailsVC, animated: true)
                }
            }
        } else {
            self.setSelectedItem(self.categoryList[indexPath.row])
            collectionView.reloadData()
            callNewMoviesList(categoryList[indexPath.item].title!)

        }
    }
    
    // invoked to add Shimmer Effect
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if(collectionView.isEqual(self.moviesCollectionView)){
            cell.setTemplateWithSubviews(isLoadingMovies, animate: true, viewBackgroundColor: .black)
        }
    }
    
    // invoked when we click on like image
    @objc func customCellButtonTapped(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: moviesCollectionView)
        guard let indexPath = moviesCollectionView.indexPathForItem(at: point)  else { return }
        print(indexPath.row)

        filteredListMovies[indexPath.row].isFavourite = !filteredListMovies[indexPath.row].isFavourite
        
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

// MARK: - SearchVC Delegate Flow Layout
extension SearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         if(collectionView.isEqual(self.moviesCollectionView)){
             return CGSize(width: self.view.frame.width/3 - 12, height: self.view.frame.height/3 - 60)
         } else {
             return CGSize(width: self.view.frame.width/3 - 12, height: 50)
         }
    }
}

