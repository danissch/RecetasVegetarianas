//
//  Connectivity.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 4/05/23.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    class func checkInternetConnection(viewController:UIViewController, actionOnNoConnection:()->()?) {
        if !Connectivity.isConnectedToInternet {
            //closeRefresh()
            actionOnNoConnection()
            let alert = UIAlertController(title: "¿Tienes conexión a internet?", message: "Revisa tu conexión y vuelve a intentarlo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            viewController.present(alert, animated: true)
            return
         }
    }
}
