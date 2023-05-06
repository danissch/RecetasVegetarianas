//
//  EndpointList.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation

enum EndpointList {
    case listarecetas
    
    var url: String? {
        guard let dictionaryOfEndpoints = EndpointList.endpointsDictionary else {
            return nil
        }
        
        switch self {
        default:
            return dictionaryOfEndpoints[String(describing: self)]
        }
    }
    
    static var endpointsDictionary: [String: String]? {
        guard let path = Bundle.main.path(forResource: EndpointListFile.endpointsFile,
                                          ofType: EndpointListFile.endpointsFileExtension) else {
            return nil
        }
        
        return NSDictionary(contentsOfFile: path) as? [String: String]
    }
    
    static func buildAndSetURL(url: String?, service: EndpointList?) -> String {
        var newUrl = ""
        if url == nil, service != nil{
            newUrl = EnvironmentManager.shared.currentEnvironment
            newUrl += service?.url ?? ""
        }else{
            newUrl = url ?? ""
        }
        return newUrl
    }
    
}

struct EndpointListFile {
    static let endpointsFile = "EndpointList"
    static let endpointsFileExtension = "plist"
}


