//
//  EventServices.swift
//  Bokadirekt
//
//  Created by Money Mahesh on 10/12/18.
//  Copyright © 2018 quarks. All rights reserved.
//

import Foundation
import Alamofire

class EventServices: MBAlamofireServerConnect {
    
    func hitEventPostService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/events", method: .post, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if statusCode == 200 {
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (nil, nil), ERROR_CANCELLED_SUCCESSFULLY)
            }
            else if let serverResponse = serverResponse as? NSDictionary, statusCode != 200 {
                let errorParserObj: ErrorParser = ErrorParser(fromDictionary: serverResponse)
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (errorParserObj, nil), nil)
            }
            else {
                self.completionBlockWithFailure?(nil, self.requestTag, nil)
            }
        }, failure: {(url : String?, error: Error?) in
            self.completionBlockWithFailure?(nil, self.requestTag, error)
        })
    }
    
    func hitEventListService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/events", method: .get, parameters: parameters, encoding: URLEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSArray {
                
                if serverResponse.count > 0 {
                    
                    var eventArray = [EventParser]()
                    for obj in serverResponse {
                        let eventParserObj = EventParser(fromDictionary: obj as! NSDictionary)
                        eventArray.append(eventParserObj)
                    }
                    self.completionBlockWithSuccess?(url, serverResponse.count > 0 ? 1 : 0, self.requestTag, (eventArray, nil), nil)
                }
                else {
                    self.completionBlockWithSuccess?(url, 0, self.requestTag, (nil, nil), dataNotAvaialble())
                }
            }
            else {
                self.completionBlockWithFailure?(nil, self.requestTag, nil)
            }
        }, failure: {(url : String?, error: Error?) in
            self.completionBlockWithFailure?(nil, self.requestTag, error)
        })
    }
}
