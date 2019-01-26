//
//  CastUtility.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
class CastUtility {
    
    static public func castSafely<T>(_ object: Any, expectedType: T.Type) -> T {
        guard let typedObject = object as? T else {
            fatalError("ERROR IN castSafely Expected object: \(object) to be of type: \(expectedType)")
        }
        return typedObject
    }
}

