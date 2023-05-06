//
//  APIHeaders.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation

struct APIHeaders {
    
    static func getHeaders() -> [String:String]{
        var headers:[String:String] = [:]
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["Cache-Control"] = "max-age=0"
        return headers
    }
    
}
