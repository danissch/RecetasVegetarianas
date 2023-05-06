//
//  RecetaDetailViewModelTests.swift
//  RecetasAppTests
//
//  Created by Daniel Duran Schutz on 4/05/23.
//

import XCTest
@testable import RecetasApp

class RecetaDetailViewModelTests:XCTestCase {
    var sut:RecetaDetailViewModel!
    var recetaMock:Receta!
    
    override func setUp() {
        super.setUp()
        goToGetRecetaFinished()
    }
    
    override func tearDown() {
        sut = nil
        recetaMock = nil
        super.tearDown()
    }
    
    func test_handleGoToAction_ImageDetailView(){
        let indexPath = IndexPath(row: 0, section: 0)
        sut.handleGoToAction(indexPath: indexPath)
        XCTAssertEqual(indexPath.row, sut.rowSelected)
    }
    
    func test_handleGoToAction_MapView(){
        let indexPath = IndexPath(row:4,section:0)
        sut.handleGoToAction(indexPath: indexPath)
        XCTAssertEqual(indexPath.row, sut.rowSelected)
    }
    
    func test_mediaUrlDomainIsCorrect(){
        let baseMediaURL = Environments.media.rawValue
        let isInReceta = sut.receta?.imagen?.contains(baseMediaURL) ?? false
        XCTAssertTrue(isInReceta)
    }
    
    func test_getMediaURL(){
        guard let stringURL = sut.receta?.imagen else {
            XCTFail()
            return
        }
        
        if let url = URL(string: stringURL),
            let _ = url.scheme,
            let _ = url.host {
            XCTAssert(true)
        } else {
            XCTFail()
        }
    }
    
    func test_getMediaURL_notNil(){
        let url = sut.getMediaURL()
        XCTAssertNotNil(url)
    }
    
    func test_getContent(){
        let contentDescription = sut.getContent(contentType: .descripcion)
        let contentIngredients = sut.getContent(contentType: .ingredientes)
        let contentPreparing = sut.getContent(contentType: .preparacion)
        
        XCTAssertEqual(recetaMock.descripcion, contentDescription.text)
        XCTAssertEqual(recetaMock.ingredientes, contentIngredients.text)
        XCTAssertEqual(recetaMock.preparacion, contentPreparing.text)
    }
    
    
    
}

extension RecetaDetailViewModelTests{
    private func goToGetRecetaFinished(){
        recetaMock = StubGenerator().stubReceta()
        sut = RecetaDetailViewModel(receta: recetaMock)
    }
}
