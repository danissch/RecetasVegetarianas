//
//  APIServiceListaRecetas.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation

final class APIServiceListaRecetas: APIServiceProtocol {
    
    func fetchData(completion: @escaping (Recetas?, String?) -> ()) {
        
        let networkCall = NetworkCall(service: .listarecetas, isJSONRequest: false)
        networkCall.executeQuery { (result: Result<Recetas, Error>, json, code, data) in
            switch result {
            case .success(let value):
                completion(value, nil)
                break
            case .failure(let error):
                completion(nil, error.localizedDescription)
                break
            }
        }
    }
    
    
}
