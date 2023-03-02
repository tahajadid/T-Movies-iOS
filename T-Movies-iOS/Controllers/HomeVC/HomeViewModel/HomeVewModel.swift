//
//  HomeVewModel.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 2/3/2023.
//

import Combine
import Foundation

class HomeViewModel {

    @Published var movieResponse: MoviesResponse?
    @Published var error: String?
    let movieRepository = MovieRepository()


    func getMoviesResponse() {
        movieRepository.callGetMoviesInfo(completion: { [self]success, model, error in
        if success {
            print("values = \(String(describing: model))")
            movieResponse = model!
    
        }
        })
        
    }

}
