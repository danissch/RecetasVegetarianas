//
//  ServiceListaRecetasTests.swift
//  RecetasAppTests
//
//  Created by Daniel Duran Schutz on 30/04/23.
//

//import Foundation
import XCTest
@testable import RecetasApp

class ServiceListaRecetasTests:XCTestCase {
    var sut: APIServiceListaRecetas?
    
    override func setUp() {
        super.setUp()
        sut = APIServiceListaRecetas()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_fetchData(){
        let sut = self.sut
        
        let expect = XCTestExpectation(description: "callback")
        sut?.fetchData(completion: { (recetas, error) in
            expect.fulfill()
            XCTAssertEqual(recetas?.count, 10)
            for receta in recetas ?? [] {
                XCTAssertNotNil(receta.nombre)
            }
        })
        
        wait(for: [expect], timeout: 3)
    }
    
}
