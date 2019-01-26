//
//  FlightsNetworkInput.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol FlightsNetworkInputProtocol {
    
    var origin: String { get set }
    var destination: String { get set }
    var dateOut: String { get set }
    var dateIn: String { get set }
    var flexDaysBeforeOut: Int { get set }
    var flexDaysOut: Int { get set }
    var flexDaysBeforeIn: Int { get set }
    var flexDaysIn: Int { get set }
    var adt: Int { get set }
    var teen: Int { get set }
    var chd: Int { get set }
    var roundtrip: Bool { get set }
}

class FlightsNetworkInput: FlightsNetworkInputProtocol {
    var origin: String
    var destination: String
    var dateOut: String
    var dateIn: String
    var flexDaysBeforeOut: Int
    var flexDaysOut: Int
    var flexDaysBeforeIn: Int
    var flexDaysIn: Int
    var adt: Int
    var teen: Int
    var chd: Int
    var roundtrip: Bool
    
    init(origin: String, destination: String, dateOut: String, dateIn: String, flexDaysBeforeOut: Int?, flexDaysOut: Int?, flexDaysBeforeIn: Int?, flexDaysIn: Int?, adt: Int, teen: Int, chd: Int, roundtrip: Bool){
        self.origin = origin
        self.destination = destination
        self.dateOut = dateOut
        self.dateIn = dateIn
        self.flexDaysBeforeOut = flexDaysBeforeOut ?? 3
        self.flexDaysOut = flexDaysOut ?? 3
        self.flexDaysBeforeIn = flexDaysBeforeIn ?? 3
        self.flexDaysIn = flexDaysIn ?? 3
        self.adt = adt
        self.teen = teen
        self.chd = chd
        self.roundtrip = roundtrip
    }
    
    func createQueryParams() ->  String {
        let parameters = "\(NetworkConstants.Input.origin)=\(self.origin)&\(NetworkConstants.Input.destination)=\(self.destination)&\(NetworkConstants.Input.dateout)=\(self.dateOut)&\(NetworkConstants.Input.datein)=\(self.dateIn)&\(NetworkConstants.Input.flexdaysbeforeout)=\(self.flexDaysBeforeOut)&\(NetworkConstants.Input.flexdaysout)=\(self.flexDaysOut)&\(NetworkConstants.Input.flexdaysbeforein)=\(self.flexDaysBeforeIn)&\(NetworkConstants.Input.flexdaysin)=\(self.flexDaysIn)&\(NetworkConstants.Input.adt)=\(self.adt)&\(NetworkConstants.Input.teen)=\(self.teen)&\(NetworkConstants.Input.chd)=\(self.chd)&\(NetworkConstants.Input.roundtrip)=\(self.roundtrip)&ToUs=AGREED"
        return parameters
    }
}
