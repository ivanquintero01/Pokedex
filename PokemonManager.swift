//
//  PokemonManager.swift
//  Pokedex
//
//  Created by Ivan Dario Quintero Vallesteros on 16/06/22.
//

//PokemonManager implemented and consume the API
import Foundation
	
//Implement method, show pokemon list
protocol pokemonManagerDelegado {
    
    //Receive Pokemon type list parameter
    func mostrarListaPokemon (lista: [Pokemon])
    
    
}
//crate estruct PokemonManager, define process delegate
struct PokemonManager {
    var delegado: pokemonManagerDelegado?
    
    //API lookup
    func verPokemon() {
        let urlString = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
        
        //create object of type url from a String
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) { (datos, respuesta, error) in
                if error != nil {
                    
                    print("error al obtener detos de la API: ", error?.localizedDescription)
                }
                
                if let datosSeguros = datos?.parseData(quitarString: "null,"){
                    if let listaPokemon = self.parsearJSON(datosPokemon:datosSeguros){
                        
                        print("Lista Pokemon:", listaPokemon)
                        
                        delegado?.mostrarListaPokemon(lista: listaPokemon)
                    }
                   
                }
            }
            tarea.resume()
        }
    }
        
        func parsearJSON(datosPokemon:Data) -> [Pokemon]?{
            let decodificador = JSONDecoder()
            do {
                let datosDecodificados = try decodificador.decode([Pokemon].self, from: datosPokemon)
                
                return datosDecodificados
                
            } catch  {
                print("Error al decodificar los datos", error.localizedDescription)
                return nil
            }
        }
    }


extension Data{
    func parseData(quitarString palabra: String) -> Data?{
        let dataAsString = String (data: self, encoding: .utf8)
        let parseDataString = dataAsString?.replacingOccurrences(of: palabra, with: "")
        
        guard let data = parseDataString?.data(using: .utf8) else {return nil}
        return data
    }
}
