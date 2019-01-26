//
//  FlightTrackerRouter.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import UIKit
protocol FlightTrackerRouterInterface{
    
    func reloadView()
}

class FlightTrackerRouter {
    let mainRouter: MainRouterInterface
    init(mainRouter: MainRouterInterface) {
        self.mainRouter = mainRouter
    }
}

extension FlightTrackerRouter: FlightTrackerRouterInterface {
    
    func reloadView() {
        let viewController = FlightTrackerRouter.create(withMainRouter: mainRouter)
        mainRouter.create(navigationController: viewController)
    }
}

extension FlightTrackerRouter: RouterFactory {
    
    static func create(withMainRouter mainRouter: MainRouterInterface) -> UIViewController {
        let router = FlightTrackerRouter(mainRouter: mainRouter)
        let dataSource = FlightTrackerDataSource()
        let interactor = FlightTrackerInteractor(flightTrackerDataSource: dataSource)
        let presenter = FlightTrackerPresenter(router: router, interactor: interactor)
        interactor.interactorOutput = presenter
        let view = FlightTrackerViewController(nibName: "FlightTrackerViewController", bundle: nil, presenter: presenter)
        presenter.view = view
        return view
    }
}

