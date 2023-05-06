//
//  MapViewModelExtension.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 5/05/23.
//

import Foundation
import MapKit

extension MapViewModel{
    
    func getLocationCoordinate() -> CLLocationCoordinate2D {
        let coordinate2D = CLLocationCoordinate2D(
            latitude: getLatitud() ?? 0,
            longitude: getLongitud() ?? 0
        )
        return coordinate2D
    }
    
    func getAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = getCountry()
        annotation.coordinate = getLocationCoordinate()
        return annotation
    }
    
    func getCoordinateSpan_latitudeDelta() -> CLLocationDegrees {
        return 0
    }
    
    func getCoordinateSpan_longitudeDelta(zoomLevel:Double, width: Double) -> CLLocationDegrees {
        return 360 / pow(2, Double(zoomLevel)) * Double(width) / 256
    }
    
    func getCoordinateSpan(zoomLevel: Int, width:Double) -> MKCoordinateSpan {
        let span = MKCoordinateSpan(
            latitudeDelta: getCoordinateSpan_latitudeDelta(),
            longitudeDelta: getCoordinateSpan_longitudeDelta(zoomLevel: 11, width: width)
        )
        return span
    }
     
}
