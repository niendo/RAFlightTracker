//
//  FlightTrackerDataSource.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol FlightTrackerDataSourceInterface: ServiceConnectionHelper {
    func getStations(handle: @escaping IntServiceHandler)
    func getFlights(params: String, handle: @escaping IntServiceHandler)
}

class FlightTrackerDataSource {
    var getStationsUrl: String {
        return "https://tripstest.ryanair.com/static/stations.json"
    }
    
    var getFlightsUrl: String {
        return "https://sit-nativeapps.ryanair.com/api/v4/Availability?"
    }
}
extension FlightTrackerDataSource: FlightTrackerDataSourceInterface {
    func getStations(handle: @escaping IntServiceHandler) {
        makePetition(urlString: getStationsUrl, method: HttpPetitionMethod.get.stringify(), headers: nil, params: nil, handle: handle, refresh: true)
    }
    
    func getFlights(params: String, handle: @escaping IntServiceHandler) {
        makePetition(urlString: "\(getFlightsUrl)\(params)", method: HttpPetitionMethod.get.stringify(), headers: nil, params: nil, handle: handle)
    }
}

