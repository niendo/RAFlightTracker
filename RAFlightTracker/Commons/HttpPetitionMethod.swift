//
//  HttpPetitionMethod.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
enum HttpPetitionMethod: String {
    case get
    case post
    case put
    case patch
    case delete
    
    func stringify() -> String {
        return self.rawValue.uppercased()
    }
}
