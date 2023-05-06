//
//  NSObjectExtension.swift
//  RecetasApp
//
//  Created by Daniel Duran Schutz on 2/05/23.
//

import Foundation

extension NSObject {
    
    @objc class var stringRepresentation:String {
        let name = String(describing: self)
        return name
    }
    
}
