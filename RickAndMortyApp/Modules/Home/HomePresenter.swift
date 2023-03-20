//
//  HomePresenter.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation
import UIKit

protocol HomePresenterDelegate: AnyObject {
    func dataLoaded()
    func showLoading(_ loading: Bool)
    func showNotFoundMessage()
    func showCollectionView(_ show: Bool)
}

class HomePresenter {
    
    private let homeManager: HomeManagerServicing
    private var characters: [Results] = []
    
    var page: Int = 1
    var total: Int = 0
    
    var numberOfRows: Int {
        characters.count
    }
    
    var delegate: HomePresenterDelegate?
    
    init(homeManager: HomeManagerServicing) {
        self.homeManager = homeManager
    }
    
    func getCharacter(for row: Int) -> Results {
        characters[row]
    }
    
    func loadCharacters() {
        
        delegate?.showLoading(true)
        
        homeManager.loadCharacters(page: page) { [weak self] result in
            
            guard let self = self else { return }
            
            self.delegate?.showLoading(false)
            self.delegate?.showCollectionView(true)
            
            switch result {
                case .success(let list):
                    guard let list = list else { return }
                    let info = list.info
                    let character = list.results
                    
                    self.characters += character
                    self.total = info.count
                    print("Total characters: \(self.total) - already included: \(self.characters.count)")
                    self.delegate?.dataLoaded()
                case .failure:
                    self.delegate?.showNotFoundMessage()
            }
        }
    }
    
    func loadMoreCharacters(at index: Int) {
        
        if index == numberOfRows - 2 &&
            numberOfRows != total {
            
            page += 1
            self.loadCharacters()
            print("Loading more Characters")
        }
    }
    
    func showDetails(character: Results) {
        HomeRouter().showDetails(character: character)
    }
    
}
