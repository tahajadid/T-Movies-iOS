//
//  IntExtensions.swift
//  T-Movies-iOS
//
//  Created by Taha JADID on 1/3/2023.
//

import Foundation

extension Int {
    
    /*
     This function to get if the number statusCode is valid or not
     */
    func isValidStatusCode() -> Bool {
        let arrSuccess = 200...299
        return arrSuccess.contains(self)
    }
}
