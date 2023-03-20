//
//  characterCell.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    @IBOutlet weak var vwCharacter: UIView?
    @IBOutlet weak var imgCharacter: UIImageView?
    @IBOutlet weak var lblCharacterName: UILabel?
    @IBOutlet weak var lblcharacterSpecies: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.vwCharacter?.backgroundColor = .clear
        self.vwCharacter?.layer.cornerRadius = 16
        self.vwCharacter?.layer.shadowColor = UIColor(named: "Neon-verde")?.cgColor
        self.vwCharacter?.layer.shadowRadius = 5.0
        self.vwCharacter?.layer.shadowOpacity = 0.5
        self.vwCharacter?.layer.shadowOffset = .zero
        self.vwCharacter?.clipsToBounds = true
        
        
        self.imgCharacter?.layer.cornerRadius = 16
        self.imgCharacter?.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.imgCharacter?.clipsToBounds = true
    }
    
    func loadUI(_ character: Results) {
        
        let imageUrl = character.image
        imageUrl.load { image in
            self.imgCharacter?.image = image
        }
        self.lblCharacterName?.text = character.name
        self.lblcharacterSpecies?.text = character.species
    }
    
}
