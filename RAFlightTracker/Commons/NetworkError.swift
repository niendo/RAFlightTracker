//
//  NetworkError.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
class NetworkError {
    var message: String?
    var responseCode: Int?
    init(code: Int, message: String) {
        self.responseCode = code
        self.message = message
    }
}
