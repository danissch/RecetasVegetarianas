//
//  DetalleRecetaRouter.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 3/05/23.
//

import Foundation
import UIKit

extension UIViewController {

    func goTo_RecetaDetailViewController(receta:Receta) {
        let vc = RecetaDetailViewController.instantiateFromXIB() as RecetaDetailViewController
        vc.item = receta
        self.pushVc(vc, animated: true, navigationBarIsHidden: false)
    }
}
