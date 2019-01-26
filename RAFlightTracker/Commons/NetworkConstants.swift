//
//  NetworkConstants.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
struct NetworkConstants {
    struct Input {
        static let origin = "origin"
        static let destination = "destination"
        static let dateout = "dateout"
        static let datein = "datein"
        static let flexdaysbeforeout = "flexdaysbeforeout"
        static let flexdaysout = "flexdaysout"
        static let flexdaysbeforein = "flexdaysbeforein"
        static let flexdaysin = "flexdaysin"
        static let adt = "adt"
        static let teen = "teen"
        static let chd = "chd"
        static let roundtrip = "roundtrip"
    }
    
    struct Output{
        static let stations = "stations"
        static let code = "code"
        static let countryCode = "countryCode"
        static let countryName = "countryName"
        static let markets = "markets"
        static let regularFare = "regularFare"
        static let businessFare = "businessFare"
        static let currency = "currency"
        static let date = "date"
        static let dates = "dates"
        static let trips = "trips"
        static let flights = "flights"
        static let time = "time"
        static let flightNumber = "flightNumber"
        static let dateOut = "dateOut"
        static let fares = "fares"
        static let regularFares = "regularFares"
        static let amount = "amount"
        static let count = "count"
        static let type = "type"
        static let hasDiscount = "hasDiscount"
        static let publishedFare = "publishedFare"
    }
}
