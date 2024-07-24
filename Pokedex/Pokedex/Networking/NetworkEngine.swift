//
//  NetworkEngine.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation

class NetworkEngine {
    static func requestGeneric(request: URLRequest, withBackRest: Bool = false, completion: ((Data?, HTTPURLResponse?, NSError?) -> Void)?) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let error = error as? NSError, error.isNetworkConnectionError else {
                guard let response = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        guard let completion = completion else { return }
                        completion(nil, nil, error as NSError?)
                    }
                    return
                }
                guard let resultData = data else {
                    DispatchQueue.main.async {
                        guard let completion = completion else { return }
                        completion(data, nil, error as NSError?)
                    }
                    return
                }
                
                self.manageHttpCodeResponse(response: response, data: resultData, error: error, request: request, completion: { (data, response, error) in
                    guard let completion = completion else { return }
                    completion(data, response, error as NSError?)
                })
                return
            }
            
            if withBackRest {
                InternetConnectionManager.shared.add(retryRequest: RequestRetry(request: request, completion: completion))
            }
            DispatchQueue.main.async {
                guard let completion = completion else { return }
                completion(nil, nil, error as NSError?)
            }
        }.resume()
    }
    
    private static func manageHttpCodeResponse(response: HTTPURLResponse,
                                data: Data,
                                error: Error?,
                                request:URLRequest,
                                completion: @escaping(Data?, HTTPURLResponse?, Error?) -> Void) {
        switch response.statusCode {
        case 200:
            DispatchQueue.main.async {
                completion(data, response, nil)
            }
        default:
            guard let error = error else {
                completion(nil, response, NetworkError.badResponse.error)
                return
            }
            completion(nil, response, error)
        }
    }
    
}
