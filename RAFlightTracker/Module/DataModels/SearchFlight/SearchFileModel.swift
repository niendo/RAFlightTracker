//
//  SearchFileModel.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
struct SearchFlightModel {
    var origin: String?
    var originCode: String?
    var destination: String?
    var destinationCode: String?
    var departureDate: String?
    var returnDate: String?
    var adults: Int?
    var teens: Int?
    var children: Int?
    var roundTrip: Bool = false
}
