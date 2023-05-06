//
//  MapaRecetaRouter.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 3/05/23.
//

import Foundation
import UIKit

extension UIViewController {
    func goTo_MapViewController(receta:Receta){
        let vc = MapViewController.instantiateFromXIB() as MapViewController
        let mapItem = MapItem(
            coordinates: receta.originLocation,
            country: receta.country,
            barTitle: "Origen: \(receta.country)"
        )
        vc.viewModel = MapViewModel(mapItem: mapItem)
        self.pushVc(vc, animated: true, navigationBarIsHidden: false)
    }
}
