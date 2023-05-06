//
//  StubGenerator.swift
//  RecetasAppTests
//
//  Created by Daniel Duran Schutz on 1/05/23.
//

import Foundation
@testable import RecetasApp

class StubGenerator {
    func stubRecetas() -> [Receta] {
        var recetas:[Receta] = []
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.url(forResource: "MockRecetas", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(RecetasApp.Recetas.self, from: data)
                recetas = jsonData
            } catch {
                print("appflow:: error:\(error)")
            }
        }
        return recetas
    }
    
    func stubReceta() -> Receta {
        
        if let receta = stubRecetas()[0] as Receta? {
            return receta
        }
        
        return Receta(
            id: 0,
            imagen: nil,
            nombre: "",
            descripcion: "",
            ingredientes: "",
            preparacion: "",
            originLocation: RecetaLocation(latitud: "", longitud: ""),
            country: ""
        )
        
    }
    
    func stubMapItem() -> MapItem {
        let mapItem = MapItem(coordinates: stubReceta().originLocation, country: stubReceta().country, barTitle: "title")
        return mapItem
    }
    
}
