//
//  Images.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 24/07/24.
//

import Foundation
import UIKit

protocol ImageProtocol {
    var image: UIImage? { get }
}

enum Images: String, ImageProtocol {
    case launchIcon
    case placeHolder
    
    var image: UIImage? {
        return Image(named: self.rawValue)
    }
    
    private func Image(named name: String) -> UIImage? {
        UIImage(named: name, in: .main, compatibleWith: nil)
    }
}
