//
//  API.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation

class API {
    
    private let router: APIRouter
    private let urlBase: URL? = URL(string: "https://pokeapi.co/api/v2/")
    
    init(router: APIRouter) {
        self.router = router
    }
    
    private func setBasicHeaders(url: inout URLRequest){
        switch router.contentType {
        case .json:
            url.setValue(ContentType.json.rawValue, forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
        }
    }
    
    func asURLRequest() -> URLRequest? {
        guard let urlBase = urlBase else { return nil }
        var urlRequest: URLRequest
        var components = URLComponents(url: urlBase, resolvingAgainstBaseURL: false)!
        components.path += router.path
        if let queryItems = router.queryParams {
            components.queryItems = queryItems
        }
        guard let url = components.url else { return nil }
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method.rawValue
        setBasicHeaders(url: &urlRequest)
        return urlRequest
    }

}

protocol APIRouter {
    var method: HTTPMethod { get }
    var path: String { get }
    var contentType: ContentType { get }
    var queryParams:  [URLQueryItem]? { get}
}

enum HTTPMethod: String {
    case get     = "GET"
}

enum ContentType: String {
    case json = "application/json"
}

enum HttpHeaderField: String {
    case contentType = "Content-Type"
}
