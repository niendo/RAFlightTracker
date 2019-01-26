//
//  FlightTrackerPresenter.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol FlightTrackerPresenterInterface {
    func viewDidLoad()
    func reloadView()
    func seachFlights(searchFlightModel: SearchFlightModel)
}

class FlightTrackerPresenter {
    var view: FlightTrackerViewControllerInterface?
    let router: FlightTrackerRouterInterface
    let interactor: FlightTrackerInteractorInputInterface
    
    init(router: FlightTrackerRouterInterface, interactor: FlightTrackerInteractor) {
        self.router = router
        self.interactor = interactor
    }
}

extension FlightTrackerPresenter: FlightTrackerPresenterInterface {
    func seachFlights(searchFlightModel: SearchFlightModel) {
        interactor.getFlights(flightsNetworkInput: FlightsNetworkInput(origin: searchFlightModel.originCode ?? "", destination: searchFlightModel.destinationCode ?? "", dateOut: searchFlightModel.departureDate ?? "", dateIn: searchFlightModel.returnDate ?? "", flexDaysBeforeOut: nil, flexDaysOut: nil, flexDaysBeforeIn: nil, flexDaysIn: nil, adt: searchFlightModel.adults ?? 1, teen: searchFlightModel.teens ?? 0, chd: searchFlightModel.children ?? 0, roundtrip: true))
        
    }
    
    func viewDidLoad() {
        self.interactor.getStations()
    }
    
    func reloadView(){
        router.reloadView()
    }
    
}

extension FlightTrackerPresenter: FlightTrackerInteractorOutputInterface {
    func getFlightsSuccess(flights: [FlightModel]) {
        self.view?.setFlightData(flights: flights)
    }
    
    func getStationsSuccess(stations: [StationModel]?) {
        self.view?.setStationData(stations: stations)
    }
    
    func getStationsError(error: NetworkError) {
        self.view?.showError(error: error.message ?? "")
    }
    
    func getFlightsError(error: NetworkError) {
        self.view?.showError(error: error.message ?? "")
    }
    
    
}
