//
//  DetallePokemonViewController.swift
//  Pokedex
//
//  Created by Ivan Dario Quintero Vallesteros on 18/06/22.
//

import UIKit

class DetallePokemonViewController: UIViewController {
    
    //MARK: - Variables
    var pokemonMostrar:Pokemon?
    
    //MARK: - Outlets
    @IBOutlet weak var defensaPokemon: UILabel!
    @IBOutlet weak var ataquePokemon: UILabel!
    @IBOutlet weak var tipoPokemon: UILabel!
    @IBOutlet weak var ImagenPokemon: UIImageView!
    @IBOutlet weak var descripcionPokemon: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Mostrar Imagen
        ImagenPokemon.loadFrom(URLAddress: pokemonMostrar?.imageUrl ?? "")

        tipoPokemon.text = "Tipo : \(pokemonMostrar?.type ?? "")"
        ataquePokemon.text = "Ataque: \(pokemonMostrar!.attack )"
        defensaPokemon.text = "Defensa: \(pokemonMostrar!.defense)"
        descripcionPokemon.text = pokemonMostrar?.description ?? ""
        
        
    }
    

    

}

extension UIImageView{
    func loadFrom(URLAddress:String){
        guard let url = URL(string: URLAddress) else { return }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data (contentsOf:url){
                if let loadImage = UIImage(data: imageData){
                    self?.image = loadImage
                }
                
            }
        }
        
    }
}
