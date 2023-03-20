//
//  DetailsRouter.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import UIKit

final class DetailsRouter {
    
    var storyboard: UIStoryboard!
    var viewController: UIViewController!
    
    init() {
        
        storyboard = UIStoryboard(name: "Details", bundle: nil)
        
        if let controller = storyboard.instantiateViewController(withIdentifier: "DetailsView") as? DetailsViewController {
            controller.presenter = DetailsPresenter(delegate: controller)
            
            viewController = controller
        }
    }
    
    func show(character: Results) {
        (self.viewController as? DetailsViewController)?.presenter.character = character
        UIApplication.topViewController()?.navigationController?.pushViewController(viewController, animated: true)
    }
}
