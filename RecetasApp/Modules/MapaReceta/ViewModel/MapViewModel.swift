//
//  MapViewModel.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 4/05/23.
//

import Foundation

class MapViewModel {
    
    var mapItem:MapItem?
    
    init(mapItem: MapItem) {
        self.mapItem = mapItem
    }
    
    func getBarTitle() -> String {
        return mapItem?.barTitle ?? "Origen"
    }
    
    func getCountry() -> String {
        return mapItem?.country ?? "Ubicación"
    }
    
    func getCoordinates() -> RecetaLocation? {
        return mapItem?.coordinates
    }
    
    func getLatitud() -> Double? {
        return Double(getCoordinates()?.latitud ?? "0") ?? 0
    }
    
    func getLongitud() -> Double? {
        return Double(getCoordinates()?.longitud ?? "0") ?? 0
    }
    
}
