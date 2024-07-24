//
//  NetworkManager.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation

class NetworkManager {
    static func request<T: Codable>(router: APIRouter, responseOfType: T.Type, withBackRest: Bool = false, completion: @escaping (_ response: HTTPURLResponse, _ result: Result<T>) -> ()) {
        InternetConnectionManager.shared.checkInternetConnection { success in
            let api = API(router: router)
            guard let request = api.asURLRequest() else {
                completion( HTTPURLResponse.init(), .failure(NetworkError.internetConnection.error))
                return
            }
            guard success else {
                if withBackRest {
                    InternetConnectionManager.shared.add(retryRequest: RequestRetry(request: request, completion: nil))
                }
                completion( HTTPURLResponse.init(), .failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet)))
                return
            }
            NetworkEngine.requestGeneric(request: request, withBackRest: withBackRest) { resultData, response, error in
                if error != nil {
                    completion(response ?? HTTPURLResponse.init(), Result<T>.failure(error))
                    return
                }
                guard let data = resultData else {
                    completion(response ?? HTTPURLResponse.init(), Result<T>.failure(NetworkError.badResponse.error))
                    return
                }
                guard let data = try? JSONDecoder().decode(T.self, from: data) else {
                    guard let response = response else {
                        completion(response ?? HTTPURLResponse.init(), Result<T>.failure(NetworkError.badResponse.error))
                        return
                    }
                    completion(response , Result<T>.failure(NetworkError.badResponse.error))
                    return
                }
                completion(response ?? HTTPURLResponse.init(), Result<T>.success(data))
            }
        }
    }
    
    static func request(router: APIRouter, withBackRest: Bool = false, completion: @escaping (_ response:HTTPURLResponse, _ result: Result<Void>) -> ()) {
        InternetConnectionManager.shared.checkInternetConnection { success in
            let api = API(router: router)
            guard let request = api.asURLRequest() else {
                completion( HTTPURLResponse.init(), .failure(NetworkError.badRequest.error))
                return
            }
            guard success else {
                if withBackRest {
                    InternetConnectionManager.shared.add(retryRequest: RequestRetry(request: request, completion: nil))
                }
                completion( HTTPURLResponse.init(), .failure(NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet)))
                return
            }
            NetworkEngine.requestGeneric(request: request, withBackRest: withBackRest) {(resultData, response, error)  in
                if error != nil {
                    completion(response ?? HTTPURLResponse.init(), .failure(error))
                    return
                }
                
                guard resultData != nil else {
                    completion(response ?? HTTPURLResponse.init(), .failure(NetworkError.badResponse.error))
                    return
                }
                completion(response ?? HTTPURLResponse.init(), .success(()))
            }
        }
    }
}

enum Result<Value> {
    case success(Value)
    case failure(NSError?)

    var isSuccess: Bool {
        switch self {
        case .success:
            return true
        case .failure:
            return false
        }
    }
    
    var isFailure: Bool {
        return !isSuccess
    }

    var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }

    var error: NSError? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}

enum NetworkError {
    case badResponse
    case badRequest
    case internetConnection
    
    var error: NSError {
        switch self {
        case .badRequest:
            return NSError(domain: "BAD REQUEST", code: 500)
        case .badResponse:
            return NSError(domain: "BAD RESPONSE", code: 401)
        case .internetConnection:
            return NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet)
        }
    }
}
