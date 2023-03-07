//
//  AppConstants.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//


import Foundation

class Constants {
    
    /*
     BASE URL
    */
    static let API_KEY = "6c134967a90569d3dcea0346a1238c82"
    static let baseURL = "https://api.themoviedb.org/3/trending/movie/day"
    static let basePopularURL = "https://api.themoviedb.org/3/trending/movie/day"
    static let baseURLImage = "https://image.tmdb.org/t/p/w500/"

    static let noNetworkWording = "No network available"
    static let noSignalIcon = "No_signal"
    static let oKWording = "OK"
    static let msgErrorServer = "Une erreur est survenue. Veuillez réessayer plus tard"

    static var menuList: [MenuOptionItem] = [
        MenuOptionItem(
            id: 0,
            title: "Home",
            image: "home_menu",
            isSelected: true
        ),
        MenuOptionItem(
            id: 1,
            title: "Favourite",
            image: "favourite_menu",
            isSelected: false
        ),
        MenuOptionItem(
            id: 2,
            title: "Settings",
            image: "setting_menu",
            isSelected: false
        )
    ]
    
    static var categoryList: [CategoryOptionItem] = [
        CategoryOptionItem(
            id: 0,
            title: "Trending",
            isSelected: true
        ),
        CategoryOptionItem(
            id: 1,
            title: "Upcoming",
            isSelected: false
        ),
        CategoryOptionItem(
            id: 2,
            title: "TV Show",
            isSelected: false
        ),
        CategoryOptionItem(
            id: 3,
            title: "Action",
            isSelected: false
        ),
        CategoryOptionItem(
            id: 4,
            title: "Top Rated",
            isSelected: false
        )
    ]
    
}
