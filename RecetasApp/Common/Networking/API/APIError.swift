//
//  APIError.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 1/05/23.
//

import Foundation

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverOverload = "Server is overloaded"
    case permissionDenied = "You don't have permission"
}
