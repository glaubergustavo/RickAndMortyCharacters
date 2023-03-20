//
//  HomeRouter.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation
import UIKit

final class HomeRouter {
    
    var storyboard: UIStoryboard!
    var viewController: UIViewController!
    
    init() {
        
        storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        if let controller = storyboard.instantiateViewController(withIdentifier: "HomeView") as? HomeViewController {
            controller.presenter = HomePresenter(homeManager: HomeManager())
            controller.presenter.delegate = controller
            viewController = controller
        }
    }
    
    func showDetails(character: Results) {
        DetailsRouter().show(character: character)
    }
}
