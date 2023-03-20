//
//  DetailsViewPresenter.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation

protocol DetailsPresenterDelegate {
    
}

final class DetailsPresenter {
    
    var character: Results!
    
    var delegate: DetailsPresenterDelegate!
    
    init(delegate: DetailsPresenterDelegate) {
        self.delegate = delegate
    }
    
}
