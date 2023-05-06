//
//  NetworkLog.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation

struct NetworkLog {
    static func paintLogs(url: String, method: String, request: [String:Any], response: [String:Any], headers:[String:Any]) {
        print("*************************************************************************")
        print("************************ servicesLog ************************************")
        print("\nX - URL: \(url)")
        print("\nX - Method: \(method)")
        print("\nX - Headers: \(getDictionaryDescription(dictionary: headers))")
        print("\nX - Parameters: \(request)")
        print("\nX - Response: \(response)")
        print("*************************************************************************")
        print("*************************************************************************")
    }
    
    static func getDictionaryDescription(dictionary:[String:Any]) -> String {
        var headersDescription = "{\n"
        for (key, value) in dictionary {
            headersDescription += "   \"\(key)\": \"\(value)\"\n"
        }
        headersDescription += "}"
        return headersDescription
    }
}
