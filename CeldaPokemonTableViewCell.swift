//
//  CeldaPokemonTableViewCell.swift
//  Pokedex
//
//  Created by Ivan Dario Quintero Vallesteros on 17/06/22.
//

import UIKit

class CeldaPokemonTableViewCell: UITableViewCell {
    
    //MARK: - Outles
    
    @IBOutlet weak var imagePokemon: UIImageView!
    @IBOutlet weak var namePokemon: UILabel!
    @IBOutlet weak var attackPokemon: UILabel!
    @IBOutlet weak var defensePokemon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imagePokemon.layer.cornerRadius = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
