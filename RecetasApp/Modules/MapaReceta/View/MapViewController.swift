//
//  MapViewController.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 3/05/23.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!

    var viewModel: MapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        self.title = viewModel?.getBarTitle()
        
        addAnnotation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.setLocation(
                zoomLevel: 11,
                animated: true
            )
        })
        
    }
    
}

extension MapViewController {
    private func addAnnotation(){
        if let annotation = viewModel?.getAnnotation() {
            mapView.addAnnotation(annotation)
        }
        
        let yourAnnotationAtIndex = 0
        let selectedAnnotation = mapView.annotations[yourAnnotationAtIndex]
        mapView.selectAnnotation(selectedAnnotation, animated: true)
    }

    private func setLocation(zoomLevel: Int, animated: Bool) {
        if let span = viewModel?.getCoordinateSpan(zoomLevel: zoomLevel, width: mapView.frame.size.width) {
            mapView.setRegion(
                MKCoordinateRegion(
                    center: self.viewModel?.getLocationCoordinate() ?? CLLocationCoordinate2D(),
                    span: span
                ),
                animated: animated
            )
        }

    }
    
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
        
}
