//
//  SearchViewModel.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 9/3/2023.
//

import Foundation

import Combine
import Foundation

class SearchViewModel {

    @Published var movieResponse: MoviesResponse?
    @Published var popularMovieResponse: MoviesResponse?
    @Published var topratedMovieResponse: MoviesResponse?
    @Published var upcomingMovieResponse: MoviesResponse?
    @Published var latestMovieResponse: MoviesResponse?
    @Published var trendingMovieResponse: MoviesResponse?

    @Published var error: String?
    
    
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
            topratedMovieResponse = model!
        }
        })
        
    }
    
    func getUpcomingMoviesResponse() {
        movieRepository.callGetUpcomingMovies(completion: { [self]success, model, error in
        if success {
            upcomingMovieResponse = model!
        }
        })
        
    }
    
    func getLatestMoviesResponse() {
        movieRepository.callGetLatestMovies(completion: { [self]success, model, error in
        if success {
            latestMovieResponse = model!
        }
        })
        
    }
    
    func getTrendingMoviesResponse() {
        movieRepository.callGetTrendingMovies(completion: { [self]success, model, error in
        if success {
            trendingMovieResponse = model!
        }
        })
        
    }

}
