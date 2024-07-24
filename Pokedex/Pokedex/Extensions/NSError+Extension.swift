//
//  NSError+Extension.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation

extension NSError {
    var isNetworkConnectionError: Bool {
        let networkErrors = [NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet]
        return domain == NSURLErrorDomain && networkErrors.contains(code)
    }
}
