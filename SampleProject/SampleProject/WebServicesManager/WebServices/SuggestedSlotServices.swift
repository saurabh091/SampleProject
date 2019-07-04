//
//  SuggestedSlotServices.swift
//  Bokadirekt
//
//  Created by Money Mahesh on 12/12/18.
//  Copyright © 2018 quarks. All rights reserved.
//

import Foundation
import Alamofire

class SuggestedSlotServices: MBAlamofireServerConnect {
    
    func hitSuggestedSlotPostService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/appointment-slots", method: .get, parameters: parameters, encoding: URLEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSArray {
                
                if serverResponse.count > 0 {
                    
                    var suggestedSlotArray = [SuggestedSlot]()
                    for obj in serverResponse {
                        let suggestedSlotObj = SuggestedSlot(fromDictionary: obj as! NSDictionary)
                        suggestedSlotArray.append(suggestedSlotObj)
                    }
                    self.completionBlockWithSuccess?(url, serverResponse.count > 0 ? 1 : 0, self.requestTag, (suggestedSlotArray, nil), nil)
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
