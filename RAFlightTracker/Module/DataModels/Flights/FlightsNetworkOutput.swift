//
//  FlightsNetworkOutput.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper

class FlightsNetworkOutput: NSObject, Mappable {
    var trips: [TripsNetworkOutput]?
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        trips <- map [NetworkConstants.Output.trips]
    }
    
}

class TripsNetworkOutput: NSObject, Mappable {
    var dates: [DatesNetworkOutput]?
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        dates <- map[NetworkConstants.Output.dates]
    }
    
}

class DatesNetworkOutput: NSObject, Mappable {
    var flights: [FlightNetworkOutput]?
    var dateout: String?
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        
        flights <- map[NetworkConstants.Output.flights]
        dateout <- map[NetworkConstants.Output.dateOut]
    }
}

class FlightNetworkOutput: NSObject, Mappable {
    var time: [String]?
    var regularFare: RegularFareNetworkOutput?
    var businessFare: BusinessFareNetworkOutput?
    var flightNumber: String?
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        time <- map[NetworkConstants.Output.time]
        regularFare <- map[NetworkConstants.Output.regularFare]
        businessFare <- map[NetworkConstants.Output.regularFare]
        flightNumber <- map[NetworkConstants.Output.flightNumber]
    }
    
}

class RegularFareNetworkOutput: NSObject, Mappable {
    var fares: [FaresNetworkOutput]?
    
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        fares <- map[NetworkConstants.Output.fares]
        
    }
}

class BusinessFareNetworkOutput: NSObject, Mappable {
    var fares: [FaresNetworkOutput]?
    
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        fares <- map[NetworkConstants.Output.fares]
        
    }
}


class FaresNetworkOutput: NSObject, Mappable {
    var amount: Float?
    var count: Int?
    var type: String?
    var hasDiscount: Bool?
    var publishedFare: Float?
    
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        amount <- map[NetworkConstants.Output.amount]
        count <- map[NetworkConstants.Output.count]
        type <- map[NetworkConstants.Output.type]
        hasDiscount <- map[NetworkConstants.Output.hasDiscount]
        publishedFare <- map[NetworkConstants.Output.publishedFare]
    }
}
