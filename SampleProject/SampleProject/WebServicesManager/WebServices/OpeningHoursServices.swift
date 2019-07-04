//
//  OpeningHoursServices.swift
//  Bokadirekt
//
//  Created by dev139 on 01/12/18.
//  Copyright © 2018 quarks. All rights reserved.
//

import UIKit
import Alamofire

class OpeningHoursServices: MBAlamofireServerConnect {
    
    func hitSlotsListService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResponse("/opening-hours?", method: .get, parameters: parameters, encoding: URLEncoding.default, headerElements: additionalHeaderElements, success: {(url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSArray {
                
//                if serverResponse.count > 0 {
                
                    var slotsArray = [OpeningSlotParser]()
                    for obj in serverResponse {
                        let slotParserObj = OpeningSlotParser(fromDictionary: obj as! NSDictionary)
                        slotsArray.append(slotParserObj)
                    }
                    self.completionBlockWithSuccess?(url, 1, self.requestTag, (slotsArray, nil), nil)
//                }
//                else {
//                    self.completionBlockWithSuccess?(url, 0, self.requestTag, (nil, nil), dataNotAvaialble())
//                }
            }
            else {
                self.completionBlockWithFailure?(nil, self.requestTag, nil)
            }
        }, failure: {(url : String?, error: Error?) in
            self.completionBlockWithFailure?(nil, self.requestTag, error)
        })
    }
    
    
    func hitAddSlotService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/opening-hours", method: .post, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSDictionary, statusCode == 200 {
                let slotObj: OpeningSlotParser = OpeningSlotParser(fromDictionary: serverResponse)
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (slotObj, nil), dataSaved())
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
    
    func hitDeleteSlotService(openingHoursId: String, additionalHeaderElements: [String: String]?) {
        
        let methodName = "/opening-hours/" + openingHoursId
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp(methodName, method: .delete, parameters: nil, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any?) in
            
//            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if statusCode == 200 {
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (nil, nil), ERROR_DELETED_SUCCESSFULLY)
            }
            else if let serverResponse = responseObject as? NSDictionary, statusCode != 200 {
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

}
