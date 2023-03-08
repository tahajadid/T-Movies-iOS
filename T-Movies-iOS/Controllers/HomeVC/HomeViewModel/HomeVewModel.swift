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
    
    @Published var popularMovieResponse: MoviesResponse?
    
    let movieRepository = MovieRepository()


    func getMoviesResponse() {
        movieRepository.callGetMoviesInfo(completion: { [self]success, model, error in
        if success {
            movieResponse = model!
        }
        })
        
    }
    
    
    func getPopularMoviesResponse() {
        movieRepository.callGetPopularMovies(completion: { [self]success, model, error in
        if success {
            popularMovieResponse = model!
        }
        })
        
    }
    
    func getTopRatedMoviesResponse() {
        movieRepository.callGetTopRatedMovies(completion: { [self]success, model, error in
        if success {
            popularMovieResponse = model!
        }
        })
        
    }
    
    func getUpcomingMoviesResponse() {
        movieRepository.callGetUpcomingMovies(completion: { [self]success, model, error in
        if success {
            popularMovieResponse = model!
        }
        })
        
    }

}
