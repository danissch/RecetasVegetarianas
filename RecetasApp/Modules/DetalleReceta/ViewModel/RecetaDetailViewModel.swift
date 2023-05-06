//
//  RecetaDetailViewModel.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 4/05/23.
//

import Foundation

class RecetaDetailViewModel {
    var receta: Receta?
    var viewController: RecetaDetailViewController?
    var rowSelected: Int?
    
    init(receta: Receta? = nil, viewController:RecetaDetailViewController? = RecetaDetailViewController()) {
        self.receta = receta
        self.viewController = viewController
    }
    
    func handleGoToAction(indexPath:IndexPath){
        if let receta = self.receta {
            switch indexPath.row {
            case 0:
                rowSelected = indexPath.row
                viewController?.goTo_ImageDetailViewController(receta: receta)
                break
            case 4:
                rowSelected = indexPath.row
                viewController?.goTo_MapViewController(receta: receta)
                break
            default: break
                
            }
            
        }
    }

}

extension RecetaDetailViewModel {
    func getMediaURL() -> URL? {
        return URL(string: receta?.imagen ?? "")
    }
    
    func getContent(contentType: RecetaContentType) -> ContentDescription {
        var title = ""
        var text = ""
        
        switch contentType {
        case .descripcion:
            title = receta?.nombre ?? ""
            text = receta?.descripcion ?? ""
            
        case .ingredientes:
            title = "INGREDIENTES"
            text = receta?.ingredientes ?? ""
            
        case .preparacion:
            title = "PREPARACIÓN"
            text = receta?.preparacion ?? ""
        }
        return ContentDescription(title: title, text: text)
    }
}

enum RecetaContentType {
    case descripcion
    case ingredientes
    case preparacion
}

