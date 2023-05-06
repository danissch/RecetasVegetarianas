//
//  ListaRecetasViewModel.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

import Foundation

class MainViewModel {
    
    var recetas: Recetas = []
    var isLoading = false
    var alertMessage = ""
    var filteredRecetas: Recetas = []
    
    var isSearching: Bool = false
    
    let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIServiceListaRecetas()) {
        self.apiService = apiService
    }
    
    func obtenerRecetas(completion:@escaping (Bool)->()){
        self.isLoading = true
        apiService.fetchData { recetas, error in
            self.isLoading = false
            if let errorMessage = error {
                print("appflow:: obtenerRecetas errorMessage:", errorMessage)
                self.alertMessage = errorMessage
                completion(false)
                return
            }
            
            guard let data = recetas else {
                completion(false)
                return
            }
            
            self.recetas = data
            completion(true)
            
        }
        
    }
    
}

extension MainViewModel {
    func handleItemAction(indexPath: IndexPath, action:@escaping (Receta)->()){
        let count = recetasCount()
        if count == 0 { return }
        let list = getRecetasList()

        if let receta = list?[indexPath.row] {
            action(receta)
        }
    }
    
    func getRecetasListCount() -> Int {
        let recetasListCount = recetasCount()
        let filteredRecetasListCount = filteredRecetasCount()
        let count = isSearching ? filteredRecetasListCount : recetasListCount
        return count
    }
    
    func getRecetasList() -> [Receta]? {
        let recetasList = recetas
        let filteredRecetasList = filteredRecetas
        let list = isSearching ? filteredRecetasList : recetasList
        return list
    }
    
}

extension MainViewModel {
    func recetasCount() -> Int {
        return recetas.count
    }
        
    func filteredRecetasCount() -> Int {
        return filteredRecetas.count
    }
}
