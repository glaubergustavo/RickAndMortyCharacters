//
//  Info.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation

struct Info: Codable {
    var count, pages: Int
    var next: String?
    var prev: String?
}
