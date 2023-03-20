//
//  DetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import UIKit

final class DetailsViewController: UIViewController,
                                   DetailsPresenterDelegate {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblSpecies: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblCreated: UILabel!
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var imgGreatCharacter: UIImageView!
    
    var centerYConstraint: NSLayoutConstraint?
    var imageCharacter: UIImage?
    
    var presenter: DetailsPresenter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadUI()
        self.showAnimation()
    }
    
    private func loadUI() {
        
        let imageUrl = presenter.character.image
        imageUrl.load { image in
            self.imageCharacter = image
            self.imgCharacter.image = image
        }
        self.lblName.text = presenter.character.name
        self.lblGender.text = presenter.character.gender
        self.lblStatus.text = presenter.character.status
        self.lblSpecies.text = presenter.character.species
        self.lblCreated.text = presenter.character.created.formattedDate()
    }
    
    private func configUI() {
        
        self.hideAnimation()
        
        navigationItem.hidesBackButton = true
        
        btnBack.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
        
        self.configCharacterImage()
        self.configbackgroundView()
    }
    
    private func configbackgroundView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideGreatCharacterImage(_:)))
        vwBackground.addGestureRecognizer(tapGesture)
        vwBackground.isUserInteractionEnabled = true
    }
    
    @objc func hideGreatCharacterImage(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            self.vwBackground.alpha = 0
            self.imgGreatCharacter.alpha = 0
        }
    }
    
    private func configCharacterImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showGreatCharacterImage(_:)))
        imgCharacter.addGestureRecognizer(tapGesture)
        imgCharacter.isUserInteractionEnabled = true
        
        imgCharacter.layer.cornerRadius = imgCharacter.frame.height / 2
        imgCharacter.layer.borderColor = UIColor(red: 0.012, green: 0.376, blue: 0.043, alpha: 1).cgColor
        imgCharacter.layer.borderWidth = 4
    }
    
    @objc func showGreatCharacterImage(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            self.vwBackground.alpha = 0.7
            self.imgGreatCharacter.alpha = 1
            self.imgGreatCharacter.image = self.imageCharacter
            self.imgGreatCharacter.layer.cornerRadius = 16
        }
    }
    
    private func hideAnimation() {
        if self.centerYConstraint != nil {
            view.removeConstraint(self.centerYConstraint!)
        }
        
        self.centerYConstraint = NSLayoutConstraint(item: self.imgCharacter as Any,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .bottom,
                                                    multiplier: 1,
                                                    constant: 0)
        
        view.addConstraint(self.centerYConstraint!)
        
        view.layoutIfNeeded()
    }
    
    private func showAnimation() {
        
        if self.centerYConstraint != nil {
            self.view.removeConstraint(self.centerYConstraint!)
        }
        
        UIView.animate(withDuration: 0.7) {
            
            self.centerYConstraint = NSLayoutConstraint(item: self.imgCharacter as Any,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: self.view,
                                                        attribute: .centerY,
                                                        multiplier: 1,
                                                        constant: -150)
            
            self.view.addConstraint(self.centerYConstraint!)
            
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        }
    }
    
    @objc func dismissView() {
        self.navigationController?.popViewController(animated: true)
    }
}
