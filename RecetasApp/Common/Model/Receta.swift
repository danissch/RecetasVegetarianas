//
//  Receta.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 29/04/23.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recetas = try? JSONDecoder().decode(Recetas.self, from: jsonData)

import Foundation

// MARK: - Receta
struct Receta: Codable {
    let id:Int
    let imagen: String?
    let nombre: String
    let descripcion:String
    let ingredientes: String
    let preparacion: String
    let originLocation: RecetaLocation
    let country:String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imagen = "imagen"
        case nombre = "nombre"
        case descripcion = "descripcion"
        case ingredientes = "ingredientes"
        case preparacion = "preparacion"
        case originLocation = "origin_location"
        case country = "country"
    }
}

typealias Recetas = [Receta]


struct RecetaLocation:Codable {
    let latitud:String
    let longitud:String
    
    enum CodingKeys:String, CodingKey {
        case latitud = "latitud"
        case longitud = "longitud"
    }
}
