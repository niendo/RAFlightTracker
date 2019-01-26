//
//  FlightTrackerInteractor.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper

protocol FlightTrackerInteractorInputInterface {
    func getStations()
    func getFlights(flightsNetworkInput: FlightsNetworkInput)
}

protocol FlightTrackerInteractorOutputInterface: class{
    func getStationsSuccess(stations: [StationModel]?)
    func getStationsError(error: NetworkError)
    
    func getFlightsSuccess(flights: [FlightModel])
    func getFlightsError(error: NetworkError)
    
}

class FlightTrackerInteractor {
    
    let flightTrackerDatasource: FlightTrackerDataSourceInterface
    weak var interactorOutput: FlightTrackerInteractorOutputInterface?
    
    init(flightTrackerDataSource: FlightTrackerDataSourceInterface) {
        self.flightTrackerDatasource = flightTrackerDataSource
    }
}

extension FlightTrackerInteractor: FlightTrackerInteractorInputInterface {
    
    func getStations() {
        
        if !Reachability.isConnectedToNetwork(){
            let error = NetworkError(code: 0, message: "NO INTERNET CONNECTION")
            
            self.interactorOutput?.getStationsError(error: error)
            
        }else{
            self.flightTrackerDatasource.getStations(){  [weak self] (code, response) in
                switch code {
                case 200, 201:
                    if let stationsNetworkOutput = Mapper<StationNetworkOutput>().map(JSONObject
                        : response) {
                        
                        self?.interactorOutput?.getStationsSuccess(stations: stationsNetworkOutput.stations)
                        
                    } else {
                        let error = NetworkError(code: 1, message: "JSON FORMAT UNKNOWN")
                        self?.interactorOutput?.getStationsError(error: error)
                    }
                default:
                    print("default")
                    let error = NetworkError(code: code, message: "SERVICE ERROR")
                    self?.interactorOutput?.getStationsError(error: error)
                    
                }
            }
        }
    }
    
    func getFlights(flightsNetworkInput: FlightsNetworkInput) {
        
        if !Reachability.isConnectedToNetwork(){
            let error = NetworkError(code: 0, message: "NO INTERNET CONNECTION")

            self.interactorOutput?.getStationsError(error: error)
            
        }else{
            self.flightTrackerDatasource.getFlights(params: flightsNetworkInput.createQueryParams()){  [weak self] (code, response) in
                //
                switch code {
                case 200, 201:
                    if let flightsNetworkOutput = Mapper<FlightsNetworkOutput>().map(JSONObject
                        : response) {
                        var flightsModel: [FlightModel] = []
                        
                        if let dates = flightsNetworkOutput.trips?[0].dates {
                            for date in dates {
                                if let flights = date.flights {
                                    for flight in flights {
                                        let flightModel = FlightModel(flightNetworkOutput: flight, date: date.dateout ?? "")
                                        flightsModel.append(flightModel)
                                    }
                                    
                                }
                            }
                        }
                        self?.interactorOutput?.getFlightsSuccess(flights: flightsModel)
                    } else {
                        let error = NetworkError(code: 1, message: "JSON FORMAT UNKNOWN")
                        self?.interactorOutput?.getFlightsError(error: error)
                    }
                    
                default:
                    let error = NetworkError(code: code, message: "SERVICE ERROR")
                    self?.interactorOutput?.getFlightsError(error: error)

                    
                }
            }
        }
        
    }

}
