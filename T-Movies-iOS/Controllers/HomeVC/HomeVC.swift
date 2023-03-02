//
//  HomeVC.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 27/2/2023.
//

import UIKit
import Combine

class HomeVC: UIViewController {    

    var initListMovies :MoviesResponse? = nil
    let viewModel = HomeViewModel()
    var cancellable: Set<AnyCancellable> = []

    // Hide navigationBar on the Top
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMoviesResponse()

        viewModel.$movieResponse.sink(receiveValue: { movieResponse in
            if movieResponse?.results.isEmpty == false {
                print("items : \(movieResponse!)")
                //self.initListMovies = movieResponse
                //self.loading(show: false)
            }
            print("items : \(movieResponse)")

        }).store(in: &cancellable)
        
        
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
