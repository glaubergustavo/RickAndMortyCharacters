//
//  HomeManager.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation

protocol HomeManagerServicing {
    func loadCharacters(page: Int, _ completion: @escaping (Result<Characters?, Error>) -> Void)
}

final class HomeManager: HomeManagerServicing {
    
    func loadCharacters(page: Int, _ completion: @escaping (Result<Characters?, Error>) -> Void) {
        
        let urlWithPagination: String = Constants.API.BaseURL + "?page=\(page)"
        
        guard let url = URL(string: urlWithPagination) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                self?.handle(data: data, error: error, completion: completion)
            }
        }
        task.resume()
    }
}

extension HomeManager {
    func handle(
        data: Data? = nil,
        response: HTTPURLResponse? = nil,
        error: Error? = nil,
        completion: @escaping(Result<Characters?, Error>) -> Void
    ) {
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            return
        }
        
        let jsonDecoder = JSONDecoder()
        
        do {
            let model = try jsonDecoder.decode(Characters.self, from: data)
            completion(.success(model))
        } catch {
            completion(.failure(error))
        }
    }
}
