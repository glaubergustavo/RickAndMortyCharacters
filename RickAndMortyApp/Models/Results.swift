//
//  Result.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation

struct Results: Codable {
    var id: Int
    var name, status, species, type: String
    var gender: String
    var origin, location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
}

extension Results: Equatable {
    static func ==(lhs: Results, rhs: Results) -> Bool {
        return lhs.id == rhs.id
    }
}
