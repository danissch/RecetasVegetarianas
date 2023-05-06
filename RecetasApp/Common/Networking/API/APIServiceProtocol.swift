//
//  APIServiceProtocol.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation

protocol APIServiceProtocol {
    func fetchData(completion: @escaping (Recetas?, String?) -> ())
}
