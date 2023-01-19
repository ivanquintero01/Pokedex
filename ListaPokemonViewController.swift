//
//  ViewController.swift
//  Pokedex
//
//  Created by Ivan Dario Quintero Vallesteros on 16/06/22.
//

import UIKit

class ListaPokemonViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tablaPokemon: UITableView!
    @IBOutlet weak var searchBarPokemon: UISearchBar!
    
    //MARK: - Variables
    
    //Instance object
    var pokemonManager = PokemonManager()
    
    //Arreglo guarda Pokemon
    var pokemons: [Pokemon] = []
    
    var  pokemonSelecionado:Pokemon?
    
    //llenar los datos que el usuario va escribiendo
    var pokemonFiltrados: [Pokemon] = []
    
    
        
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the new cell
        tablaPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        
        //Implement the delegates
        pokemonManager.delegado = self
        searchBarPokemon.delegate = self
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        
        
        
        // Execute the method to search the list of pokemon
        pokemonManager.verPokemon()
        
       
    
    }


}

//MARK: - SearchBar
extension ListaPokemonViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
        pokemonFiltrados = []
        
        if searchText == ""{
            pokemonFiltrados = pokemons
        }else{
            for poke in pokemons{
                if poke.name.lowercased().contains(searchText.lowercased()){
                    pokemonFiltrados.append(poke)
                }
            }
        }
        self.tablaPokemon.reloadData()
    }
}


//MARK: - Delegade Pokemon
extension ListaPokemonViewController: pokemonManagerDelegado{
    func mostrarListaPokemon(lista: [Pokemon]) {
        pokemons = lista
        
        //Actualizar interfas grafica en segundoplano
        DispatchQueue.main.async {
            self.pokemonFiltrados = lista
            self.tablaPokemon.reloadData()
        }
    }
    
    
}

//MARK: - UITableViewDelegate
extension ListaPokemonViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDataSource
extension ListaPokemonViewController: UITableViewDataSource{
    
    //Methods needed for the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        //Returns number of rows
        return pokemonFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        //create object of type celda
        let celda = tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPokemonTableViewCell
        
        celda.namePokemon.text = pokemonFiltrados[indexPath.row].name
        celda.attackPokemon.text = "Ataque:\(pokemonFiltrados[indexPath.row].attack)"
        celda.defensePokemon.text = "Defense:\(pokemonFiltrados[indexPath.row].defense)"
        
        //celda Imagen desde Url
        if let urlString = pokemonFiltrados[indexPath.row].imageUrl as? String{
            if let imageURL = URL(string: urlString){
                DispatchQueue.global().async {
                    guard let imageData = try? Data(contentsOf: imageURL) else{
                        return
                    }
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        celda.imagePokemon.image = image
                    }
                }
                
            }
        }
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonSelecionado = pokemonFiltrados[indexPath.row]
        
        performSegue(withIdentifier: "verPokemon", sender: self)
        
        //desseleccionar la tabla
        tablaPokemon.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPokemon"{
            let verPokemon = segue.destination as! DetallePokemonViewController
            verPokemon.pokemonMostrar = pokemonSelecionado
        }
    }
    
    
}
