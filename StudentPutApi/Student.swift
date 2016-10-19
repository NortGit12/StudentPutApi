//
//  Student.swift
//  StudentPutApi
//
//  Created by Jeff Norton on 10/19/16.
//  Copyright © 2016 JeffCryst. All rights reserved.
//

import Foundation

struct Student {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    let name: String
}

extension Student {
    
    //==================================================
    // MARK: - Properties
    //==================================================
    
    static let nameKey = "nombre"
    
    var dictionaryRepresentation: [String : Any] {
        
        // name value --> ["name": "Jeff"]
        return [Student.nameKey: name as Any]
    }
    
    var jsonData: Data? {
        
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted)
    }
    
    //==================================================
    // MARK: - Initializers
    //==================================================
    init?(dictionary: [String : String]) {
        
        guard let name = dictionary[Student.nameKey] else {
            return nil
        }
        
        self.init(name: name)
    }
    
    
}














