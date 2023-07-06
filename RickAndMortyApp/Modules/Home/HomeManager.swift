//
//  HomeManager.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation
import Alamofire

protocol HomeManagerServicing {
    func loadCharacters(page: Int, _ completion: @escaping (Result<Characters?, Error>) -> Void)
}

final class HomeManager: HomeManagerServicing {
    
    func loadCharacters(page: Int, _ completion: @escaping (Result<Characters?, Error>) -> Void) {
            
            let urlWithPagination: String = Constants.API.BaseURL + "?page=\(page)"
            
            AF.request(urlWithPagination).response { [weak self] response in
                DispatchQueue.main.async {
                    self?.handle(response: response, completion: completion)
                }
            }
        }
    }

    extension HomeManager {
        func handle(
            response: AFDataResponse<Data?>,
            completion: @escaping (Result<Characters?, Error>) -> Void
        ) {
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            guard let data = response.data else {
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
