//
//  StationNetworkModel.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper

class StationNetworkOutput: NSObject, Mappable {
    var stations: [StationModel]?
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        stations <- map[NetworkConstants.Output.stations]
    }
}

class StationModel: NSObject, Mappable {
    var code: String?
    var countryCode: String?
    var countryName: String?
    var markets: [MarketsNetworkOutput]?
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        code <- map[NetworkConstants.Output.code]
        countryCode <- map[NetworkConstants.Output.countryCode]
        countryName <- map[NetworkConstants.Output.countryName]
        markets <- map[NetworkConstants.Output.markets]
    }
}

class MarketsNetworkOutput: NSObject, Mappable {
    var code: String?
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        code <- map[NetworkConstants.Output.code]
        
    }
}
