//
//  APIPokemonRouter.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 23/07/24.
//

import Foundation

enum APIPokemonRouter: APIRouter {

    case getPokemons(offset: Int, limit: Int)
    case pokemonDetail(id: String)
    case pokemonSpecies(id: String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        let baseURL: String = "pokemon"
        switch self {
        case .getPokemons:
            return "\(baseURL)"
        case .pokemonDetail(let id):
            return "\(baseURL)/\(id)"
        case .pokemonSpecies(let id):
            return "\(baseURL)-species/\(id)"
        }
    }
    
    var contentType: ContentType {
        return .json
    }
    
    var queryParams: [URLQueryItem]? {
        switch self {
        case .getPokemons(let offset, let limit):
            return [URLQueryItem(name: "offset", value: String(offset)),
                    URLQueryItem(name: "limit", value: String(limit))]
        default:
            return nil
        }
    }
    
}
