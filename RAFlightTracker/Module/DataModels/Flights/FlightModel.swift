//
//  FlightModel.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
struct FlightModel {
    var date: String?
    var flightNumber: String?
    var adultFare: FareModel?
    var teenFare: FareModel?
    var childFare: FareModel?
    var totalFare: Float = 0
    
    init(flightNetworkOutput: FlightNetworkOutput, date: String) {
        self.date = date
        self.flightNumber = flightNetworkOutput.flightNumber
        
        if let fares = flightNetworkOutput.regularFare?.fares {
            for fare in fares {
                if fare.type == "ADT" {
                    totalFare += fare.amount ?? 0
                    self.adultFare = FareModel(fare: fare)
                } else if fare.type == "TEEN" {
                    totalFare += fare.amount ?? 0
                    self.teenFare = FareModel(fare: fare)
                } else if fare.type == "CHD" {
                    totalFare += fare.amount ?? 0
                    self.adultFare = FareModel(fare: fare)
                }
            }
        }  
    }
}

struct FareModel {
    var fare: Float?
    var qty: Int?
    init(fare: FaresNetworkOutput) {
        self.fare = fare.amount
        self.qty = fare.count
    }
    
}
