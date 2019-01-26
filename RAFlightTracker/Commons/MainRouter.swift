//
//  MainRouter.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import UIKit
protocol MainRouterInterface {
    func create(navigationController : UIViewController)
    func present(viewController: UIViewController, animated: Bool)
    func pushToNavigation(viewController: UIViewController, animated: Bool)
    func currentViewController() -> UIViewController?
    
}

protocol RouterFactory {
    static func create(withMainRouter mainRouter: MainRouterInterface) -> UIViewController
}

class MainRouter {
    let window: UIWindow
    var presentViewController: UIViewController?
    
    var rootViewController: UIViewController {
        
        guard let rootViewController = window.rootViewController else {
            fatalError("There is no rootViewController installed on the window")
        }
        
        return rootViewController
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension MainRouter {
    
    func presentRootViewController() {
        let flightTrackerViewController = FlightTrackerRouter.create(withMainRouter: self)
        firstViewController(viewController: flightTrackerViewController)
        presentViewController = flightTrackerViewController
        
    }
    
    
    private func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootVC?.presentedViewController == nil {
            return rootVC
        }
        
        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getVisibleViewController(presented)
        }
        return nil
    }
}

extension MainRouter: MainRouterInterface {
    
    func currentViewController() -> UIViewController? {
        return presentViewController
    }
    
    
    func firstViewController(viewController: UIViewController){
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func create(navigationController : UIViewController) {
        let rootViewController = UINavigationController(rootViewController: navigationController)
        window.rootViewController = rootViewController
        presentViewController = navigationController
        
    }
    
    func pushToNavigation(viewController: UIViewController, animated: Bool) {
        if  window.rootViewController?.navigationController == nil {
            if rootViewController is UINavigationController {
                CastUtility.castSafely(rootViewController, expectedType: UINavigationController.self).pushViewController(viewController, animated: animated)
            } else if rootViewController.navigationController != nil {
                rootViewController.navigationController!.pushViewController(viewController, animated: animated)
            }
        } else {
            window.rootViewController?.navigationController?.pushViewController(viewController, animated: animated)
        }
        presentViewController = viewController
    }
    
    func present(viewController: UIViewController, animated: Bool) {
        rootViewController.present(viewController, animated: animated, completion: nil)
        presentViewController = viewController
    }
    

    

}
