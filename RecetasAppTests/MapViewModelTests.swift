//
//  MapViewModelTests.swift
//  RecetasAppTests
//
//  Created by Daniel Duran Schutz on 5/05/23.
//

import XCTest
import CoreLocation

@testable import RecetasApp

class MapViewModelTests:XCTestCase {
    
    var sut : MapViewModel!
    var mapItem : MapItem!
    
    override func setUp() {
        super.setUp()
        mapItem = StubGenerator().stubMapItem()
        sut = MapViewModel(mapItem: mapItem)
    }
    
    override func tearDown() {
        sut  = nil
        mapItem = nil
        super.tearDown()
    }
    
    func test_getBarTitle_isNotEmpty(){
        let title = sut.getBarTitle()
        XCTAssertFalse(title.isEmpty)
    }
    
    func test_getCountry_isNotEmpty(){
        let country = sut.getCountry()
        XCTAssertFalse(country.isEmpty)
    }
    
    func test_getCoordinates_isNotEmpty(){
        let coodinates = sut.getCoordinates()
        XCTAssertNotNil(coodinates)
    }
    
    func test_getLatitud_isNotEmpty(){
        let latitud = sut.getLatitud()
        XCTAssertNotNil(latitud)
    }
    
    func test_getLongitud_isNotEmpty(){
        let longitud = sut.getLongitud()
        XCTAssertNotNil(longitud)
    }
    
    func test_getLocationCoordinate_creation_isCorrect(){
        let coordinate = sut.getLocationCoordinate()
        XCTAssertNotNil(coordinate)
        
        XCTAssertTrue(coordinate.latitude != 0)
        XCTAssertTrue(coordinate.longitude != 0)
    
        let newCoordinate = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        XCTAssertNotNil(newCoordinate)
        
        XCTAssertTrue(newCoordinate.latitude != 0)
        XCTAssertTrue(newCoordinate.longitude != 0)
        
        let annotation = sut.getAnnotation()
        XCTAssertEqual(annotation.coordinate.latitude, coordinate.latitude)
        XCTAssertEqual(annotation.coordinate.longitude, coordinate.longitude)
    }
    
    func test_getCoordinateSpan_longitudeDelta(){
        let zoomLevel:Double = 11
        let width:Double = 320
        let spanLongitudeCalc = 360 / pow(2, Double(zoomLevel)) * Double(width) / 256
        
        let locationLongitude:Double = sut.getCoordinateSpan_longitudeDelta(zoomLevel: zoomLevel, width: width)
        XCTAssertEqual(spanLongitudeCalc, locationLongitude)
    }
    
    func test_getBarTitle_nilCase(){
        
        sut.mapItem?.barTitle = nil
        let title = sut.getBarTitle()
        XCTAssertEqual(title, "Origen")
        
    }
    
    func test_getCountry(){
        sut.mapItem?.country = nil
        let country = sut.getCountry()
        XCTAssertEqual(country, "Ubicación")
    }
    
    func test_getCoordinateSpan_latitudeDelta_isDouble(){
        XCTAssertEqual(sut.getCoordinateSpan_latitudeDelta(), 0)
    }

    func test_getCoordinateSpan_called(){
        let zoomLevel = 1
        let width:Double = 320
        
        let span = sut.getCoordinateSpan(zoomLevel: zoomLevel, width: width)
        XCTAssertNotNil(span)
        
    }
    
}
