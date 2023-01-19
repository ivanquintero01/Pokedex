//
//  DatosPokemon.swift
//  Pokedex
//
//  Created by Ivan Dario Quintero Vallesteros on 16/06/22.
//

import Foundation

//Create structure to encode the API, define fields to consume API
struct Pokemon: Decodable,Identifiable{
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
}
