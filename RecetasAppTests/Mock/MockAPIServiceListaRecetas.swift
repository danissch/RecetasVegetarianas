//
//  MockAPIServiceListaRecetas.swift
//  RecetasAppTests
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation
//import RecetasApp
@testable import RecetasApp

final class MockAPIServiceListaRecetas:APIServiceProtocol {
    var completeClosure:((RecetasApp.Recetas?, String?) -> ())?
    var completeRecetas: [Receta] = [Receta]()
    
    //private static let delay = 5
    private static var requestCount = 1
    var isFetchDataCalled = false
    
    
    func fetchData(completion: @escaping (RecetasApp.Recetas?, String?) -> ()) {
        isFetchDataCalled = true
        
        switch MockAPIServiceListaRecetas.requestCount {
            case 0:
                DispatchQueue.main.async {
                    self.completeClosure = completion
                    completion(nil, "Error trayendo el primer request")
                }
            
            default:
                getRecetasFromFile(completion: completion)
        }
        MockAPIServiceListaRecetas.requestCount += 1
    }
    
    private func getRecetasFromFile(completion: @escaping (RecetasApp.Recetas?, String?) -> ()){
        //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(MockAPIServiceListaRecetas.delay)){
            let testBundle = Bundle(for: type(of: self))
            
            if let path = testBundle.url(forResource: "MockRecetas", withExtension: "json") {
                print("appflow:: getContentFromJSONFile: path: ", path)
                
                do {
                    let data = try Data(contentsOf: path)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(RecetasApp.Recetas.self, from: data)
                    print("appflow:: MockAPIServiceListaRecetas fetchData: jsonData: ", jsonData)
                    self.completeClosure = completion
                    completion(jsonData, nil)
                } catch {
                    print("error:\(error)")
                    self.completeClosure = completion
                    completion(nil, error.localizedDescription)
                }
            }
        //}
    }
    
    func fetchSuccess(){
        completeClosure?([Receta](), nil)
    }
    
    func fetchFail(error:APIError?){
        completeClosure?(nil, error?.rawValue)
    }
}
