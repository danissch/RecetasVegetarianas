//
//  StringsNetworkCall.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation

struct StringsNetworkCall {
    struct StatusCodeMessages{
        static func success(code:Int) -> String {
           return "Respuesta exitosa. \(code)"
        }
        static func informational(code:Int) -> String {
           return "Petición esta en proceso. \(code)"
        }
        static func redirection(code:Int) -> String {
            return "Posible redirección. \(code)"
        }
        static func clientError(code:Int) -> String {
           return "Cliente. Este recurso no se ha encontrado. \(code)"
        }
        static func serverError(code:Int) -> String {
            return "Servidor. En este momento no podemos responder a tu solicitud, intenta de nuevo mas tarde. \(code)"
        }
    }
}
