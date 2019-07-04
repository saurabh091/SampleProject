//
//  ScheduleServices.swift
//  Bokadirekt
//
//  Created by dev139 on 13/12/18.
//  Copyright © 2018 quarks. All rights reserved.
//

import Foundation
import Alamofire

class ScheduleServices: MBAlamofireServerConnect {

    func hitScheduleListService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResponse("/schedules", method: .get, parameters: parameters, encoding: URLEncoding.default, headerElements: additionalHeaderElements, success: {(url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSArray {
                
            if serverResponse.count > 0 {
                
                var scheduleArray = [ScheduleListParser]()
                for obj in serverResponse {
                    let scheduleParserObj = ScheduleListParser(fromDictionary: obj as! NSDictionary)
                    scheduleArray.append(scheduleParserObj)
                }
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (scheduleArray, nil), nil)
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
    
    func hitSaveScheduleService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/schedules", method: .post, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if statusCode == 200,  let serverResponse = serverResponse as? NSDictionary {
                let scheduleParserObj = ScheduleListParser(fromDictionary: serverResponse)
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (scheduleParserObj, nil), ERROR_SCHEDULE_SAVED)
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
    
    
    func hitDeleteScheduleService(scheduleId : Int, parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/schedules/\(scheduleId)", method: .delete, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if statusCode == 200 {
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (nil, nil), ERROR_DELETED_SUCCESSFULLY)
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
    
    func hitLoadScheduleService(scheduleId : Int, parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/schedules/\(scheduleId)/load", method: .post, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if statusCode == 200 {
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (nil, nil), ERROR_SCHEDULE_LOADED)
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

}
