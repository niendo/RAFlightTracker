//
//  ServiceConnectionHelper.swift
//  RAFlightTracker
//
//  Created by Eduardo Nieto on 26/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

typealias SuccessCompletionBlock = (_ object: AnyObject) -> Void
typealias FailureCompletionBlock = (_ error: Error) -> Void
typealias BoolServiceHandler = (Bool, AnyObject) -> Void
typealias IntServiceHandler = (Int, AnyObject) -> Void

protocol ServiceConnectionHelper {
    
}

extension ServiceConnectionHelper {
    
    func getUserHeaders() -> [String: String] {
        return
            [
                "content-type": "application/json",
                "cache-control": "no-cache",
                "Accept": "application/json;charset=UTF-8",
                "Accept-Language": "es"
        ]
    }
    
    func makePetition(urlString: String, method: String, headers: [String: String]?, params: [String: AnyObject?]?, handle: @escaping IntServiceHandler, refresh: Bool = false) {
        
        var newHeaders = headers
        if newHeaders == nil {
            newHeaders = getUserHeaders()
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        print("request url \(url)")
        print("params \(String(describing: params))")
        print("headers \(String(describing: newHeaders)))")
        print("method \(method)")
        
        request.allHTTPHeaderFields = newHeaders
        request.httpMethod = method
        var newParams: [String: AnyObject] = [:]
        if params != nil {
            for param in params! where param.value != nil {
                print("not null \(param)")
                newParams[param.key] = param.value
            }
            request.httpBody = try? JSONSerialization.data(withJSONObject: newParams, options: [])
        }
        request.timeoutInterval = 300
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss"
        
        
        Alamofire.request(request).responseJSON { response in
            if let requestBody = request.httpBody {
                
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: requestBody, options: [])
                    print("Array: \(jsonArray)")
                }
                catch {
                    print("Error: \(error)")
                }
            }
            
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if utf8Text.contains("<body>") {
                    let text1 = utf8Text.components(separatedBy: "<body>")
                    let text2 = text1[1].components(separatedBy: "</body>")
                    print("Data: \(text2[0])")
                } else {
                    print("Data: \(utf8Text)")
                }
            }
            print("RESPONSE CODE: \(response.response?.statusCode ?? 0)")
            
            if response.response != nil {
                if let responseCode = response.response?.statusCode {
                    if responseCode == 200 {
                        handle(responseCode, response.result.value as AnyObject)
                    } else {
                        
                        handle(responseCode, "Code not 200" as AnyObject)
                    }
                    
                } else {
                    handle(-1, "Server error" as AnyObject)
                    
                }
            } else {
                handle(-1, "Server error" as AnyObject)
                
            }
        }
    }
    
    
}
