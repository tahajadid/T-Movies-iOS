//
//  ApiService.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 28/2/2023.
//


import Foundation
import Alamofire

func apiRequest(method: HTTPMethod,
                url: String,
                params: [String: Any],
                headers: [String: String],
                completion:@escaping(_ finished: Bool,
                                     _ response: AnyObject?,
                                     _ statusCode: Int) -> Void) {
    Network.getNetworkState(completion: { success in
        if success {
            /*
             network on
             */
            let headers = HTTPHeaders(headers)
            var encoding: ParameterEncoding = JSONEncoding.default
            if method == .get {
                encoding = URLEncoding.default
            }
            AF.request(url, method: method,
                       parameters: params,
                       encoding: encoding,
                       headers: headers).response { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        completion(true,
                                   data as AnyObject?,
                                   response.response?.statusCode ?? -1)
                    } else {
                        completion(true,
                                   response.response as AnyObject?,
                                   response.response?.statusCode ?? -1)
                    }
                    
                case .failure(let error):
                    print(error)
                    /* If Case is failure, we can send it to VM to goal to tell user */
                    completion(false,
                               response.error as AnyObject?,
                               response.response?.statusCode ?? -1)
                }
            }
        } else {
            /*
             network off
             */
            if let topVC = UIApplication.getTopViewController() {
                topVC.showAlert(title: Constants.noNetworkWording, message: "", icon: Constants.noSignalIcon, actionTitles: [Constants.oKWording], style: [.default], actions: [{(action) in
                }], preferredActionIndex: 0)
            }
        }
    })
}
