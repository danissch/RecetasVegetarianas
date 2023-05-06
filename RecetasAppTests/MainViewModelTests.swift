//
//  ListaRecetasViewModelTests.swift
//  RecetasAppTests
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

//import Foundation
import XCTest
@testable import RecetasApp

class MainViewModelTests:XCTestCase {
    var sut:MainViewModel!
    var mockAPIServiceListaRecetas:MockAPIServiceListaRecetas!
    
    override func setUp() {
        super.setUp()
        mockAPIServiceListaRecetas = MockAPIServiceListaRecetas()
        sut = MainViewModel(apiService: mockAPIServiceListaRecetas)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIServiceListaRecetas = nil
        super.tearDown()
    }
    
    func test_obtenerRecetas(){
        let expect = XCTestExpectation(description: "callback")
        mockAPIServiceListaRecetas.completeRecetas = [Receta]()
        
        sut.obtenerRecetas { recetas in
            expect.fulfill()
            print("appflow:: test_obtenerRecetas: recetas", recetas )
        }
        XCTAssert(self.mockAPIServiceListaRecetas.isFetchDataCalled)
        wait(for: [expect], timeout: 5)
    }
    
    func test_obtenerRecetas_fail(){
        // Given a failed fetch with a certain failure
        let error = APIError.noNetwork
        sut.obtenerRecetas { recetas in }
        mockAPIServiceListaRecetas.fetchFail(error: error)
        XCTAssertEqual(sut.alertMessage, error.rawValue)
    }
    
    func test_handleItemAction(){
        let indexPath = IndexPath(row:0, section: 0)
        goToObtenerRecetasFinished()
        
        sut.handleItemAction(indexPath: indexPath, action: {receta in
            XCTAssertNotNil(receta)
        })
    }
    
    func test_recetasCount(){
        sut.recetas = StubGenerator().stubRecetas()
        let count = self.sut.recetas.count
        
        XCTAssertEqual(count, sut.recetas.count)
    }
    
    func test_getRecetasListCount_onSearch(){
        let recetas = StubGenerator().stubRecetas()
        sut.isSearching = true
        sut.recetas = recetas
        
        let filter = recetas.filter({ $0.ingredientes.contains("tomate") })
        sut.filteredRecetas = filter
        XCTAssertTrue(sut.isSearching)
        XCTAssertNotEqual(sut.filteredRecetas.count, sut.recetas.count)
        
    }
    
}

extension MainViewModelTests {
    private func goToObtenerRecetasFinished(){
        mockAPIServiceListaRecetas.completeRecetas = StubGenerator().stubRecetas()
        sut.obtenerRecetas { _ in }
        self.mockAPIServiceListaRecetas.fetchSuccess()
    }
    
    
}
