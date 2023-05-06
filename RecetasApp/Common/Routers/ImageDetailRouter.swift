//
//  ImageDetailRouter.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 3/05/23.
//

import Foundation
import UIKit

extension UIViewController {
    func goTo_ImageDetailViewController(receta:Receta){
        let vc = ImageDetailViewController.instantiateFromXIB() as ImageDetailViewController
        vc.setImage(imageUrl: receta.imagen ?? "")
        self.pushVc(vc, animated: true, navigationBarIsHidden: false)
    }
}
