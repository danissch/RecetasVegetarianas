//
//  Environment.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation

@objcMembers
class EnvironmentManager:NSObject {
    static let shared = EnvironmentManager()
    let currentEnvironment:String = Environments.production.rawValue
}

enum Environments:String {
    //MARK: - Produccion
    case production = "https://demo0063029.mockable.io"
    case development = "https://demo3079520.mockable.io"
    case media = "https://test.masquenegocios.com"
}
