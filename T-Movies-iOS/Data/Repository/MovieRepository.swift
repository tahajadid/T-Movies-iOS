//
//  MovieRepository.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 1/3/2023.
//

import Foundation
import Alamofire

class MovieRepository {

    /*
     Get Movies info
     */
    func callGetMoviesInfo(completion: @escaping((_ success: Bool,
                                                          _ model: MoviesResponse?,
                                                          _ error: String?) -> Void)) {
        var params: [String: Any] = [:]
        var headers: [String: String] = [:]
        
        params["api_key"] = "6c134967a90569d3dcea0346a1238c82"
        params["page"] = "9"
        headers["Content-Type"] = "application/json; charset=utf-8"

        apiRequest(method: .get,
                   url: Constants.baseURL,
                   params: params,
                   headers: headers) { success, response, statusCode in
            guard statusCode.isValidStatusCode() else {
                completion(false, nil, Constants.msgErrorServer)
                return
            }
            let decoder = JSONDecoder()
            do {
                let res = try decoder.decode(MoviesResponse.self, from: response as! Data)
                completion(true, res, nil)
            } catch {
                completion(false, nil, Constants.msgErrorServer)
            }
        }
    }
    
    /*
     Get Movies info
     */
    func callGetPopularMovies(completion: @escaping((_ success: Bool,
                                                          _ model: MoviesResponse?,
                                                          _ error: String?) -> Void)) {
        var params: [String: Any] = [:]
        var headers: [String: String] = [:]
        
        params["api_key"] = "6c134967a90569d3dcea0346a1238c82"
        params["page"] = "5"
        headers["Content-Type"] = "application/json; charset=utf-8"

        apiRequest(method: .get,
                   url: Constants.basePopularURL,
                   params: params,
                   headers: headers) { success, response, statusCode in
            guard statusCode.isValidStatusCode() else {
                completion(false, nil, Constants.msgErrorServer)
                return
            }
            let decoder = JSONDecoder()
            do {
                let res = try decoder.decode(MoviesResponse.self, from: response as! Data)
                completion(true, res, nil)
            } catch {
                completion(false, nil, Constants.msgErrorServer)
            }
        }
    }
    
    /*
     Get Top Rated Movies
     */
    func callGetTopRatedMovies(completion: @escaping((_ success: Bool,
                                                          _ model: MoviesResponse?,
                                                          _ error: String?) -> Void)) {
        var params: [String: Any] = [:]
        var headers: [String: String] = [:]
        
        params["api_key"] = "6c134967a90569d3dcea0346a1238c82"
        params["page"] = "5"
        headers["Content-Type"] = "application/json; charset=utf-8"

        apiRequest(method: .get,
                   url: Constants.baseTopRatedURL,
                   params: params,
                   headers: headers) { success, response, statusCode in
            guard statusCode.isValidStatusCode() else {
                completion(false, nil, Constants.msgErrorServer)
                return
            }
            let decoder = JSONDecoder()
            do {
                let res = try decoder.decode(MoviesResponse.self, from: response as! Data)
                completion(true, res, nil)
            } catch {
                completion(false, nil, Constants.msgErrorServer)
            }
        }
    }
    
    /*
     Get Top Rated Movies
     */
    func callGetUpcomingMovies(completion: @escaping((_ success: Bool,
                                                          _ model: MoviesResponse?,
                                                          _ error: String?) -> Void)) {
        var params: [String: Any] = [:]
        var headers: [String: String] = [:]
        
        params["api_key"] = "6c134967a90569d3dcea0346a1238c82"
        params["page"] = "5"
        headers["Content-Type"] = "application/json; charset=utf-8"

        apiRequest(method: .get,
                   url: Constants.baseTopUpcomingURL,
                   params: params,
                   headers: headers) { success, response, statusCode in
            guard statusCode.isValidStatusCode() else {
                completion(false, nil, Constants.msgErrorServer)
                return
            }
            let decoder = JSONDecoder()
            do {
                let res = try decoder.decode(MoviesResponse.self, from: response as! Data)
                completion(true, res, nil)
            } catch {
                completion(false, nil, Constants.msgErrorServer)
            }
        }
    }
    
    
    /*
     Get Latest Movies
     */
    func callGetLatestMovies(completion: @escaping((_ success: Bool,
                                                          _ model: MoviesResponse?,
                                                          _ error: String?) -> Void)) {
        var params: [String: Any] = [:]
        var headers: [String: String] = [:]
        
        params["api_key"] = "6c134967a90569d3dcea0346a1238c82"
        params["page"] = "5"
        headers["Content-Type"] = "application/json; charset=utf-8"

        apiRequest(method: .get,
                   url: Constants.baseTopLatestURL,
                   params: params,
                   headers: headers) { success, response, statusCode in
            guard statusCode.isValidStatusCode() else {
                completion(false, nil, Constants.msgErrorServer)
                return
            }
            let decoder = JSONDecoder()
            do {
                let res = try decoder.decode(MoviesResponse.self, from: response as! Data)
                completion(true, res, nil)
            } catch {
                completion(false, nil, Constants.msgErrorServer)
            }
        }
    }

}


