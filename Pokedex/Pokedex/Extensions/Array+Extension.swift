//
//  Array+Extension.swift
//  Pokedex
//
//  Created by David Felipe Cortes Gonzalez on 24/07/24.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
