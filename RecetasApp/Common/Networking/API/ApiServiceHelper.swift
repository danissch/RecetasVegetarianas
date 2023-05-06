//
//  ApiServiceHelper.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation

struct ApiServiceHelper {
    static func getResponseAsJson(rawResponse: (Data)) -> [String:Any]? {
        do {
            if let json = try JSONSerialization.jsonObject(with: rawResponse) as? [String: Any] {
                return json
            }
        } catch let parseError {
            let rawResponseString = String(data: rawResponse, encoding: .utf8) ?? ""
            print("\n\nX - Error: \(parseError)")
            print("\n\nX - Raw Response: \(rawResponseString)")
        }
        
        return nil
    }
    
    static func buildErrorMessage(httpStatusCode: HTTPStatusCode, code: Int) -> String {
        var errorMessage = ""
        if httpStatusCode.responseType == .informational {
            errorMessage = StringsNetworkCall.StatusCodeMessages.informational(code: code)
        } else if httpStatusCode.responseType == .redirection  {
            errorMessage = StringsNetworkCall.StatusCodeMessages.redirection(code: code)
        } else if httpStatusCode.responseType == .clientError {
            errorMessage = StringsNetworkCall.StatusCodeMessages.clientError(code: code)
        } else if httpStatusCode.responseType == .serverError {
            errorMessage = StringsNetworkCall.StatusCodeMessages.serverError(code: code)
        }
        return errorMessage
    }
    
    
}
