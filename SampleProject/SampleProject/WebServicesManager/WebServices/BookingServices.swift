//
//  BookingServices.swift
//  Bokadirekt
//
//  Created by Money Mahesh on 04/12/18.
//  Copyright © 2018 quarks. All rights reserved.
//

import Foundation
import Alamofire

class BookingServices: MBAlamofireServerConnect {
    
    func hitBookingListService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/orders?", method: .get, parameters: parameters, encoding: URLEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSArray {
                
                if serverResponse.count > 0 {
                    
                    var bookingArray = [BookingParser]()
                    for obj in serverResponse {
                        let bookingParserObj = BookingParser(fromDictionary: obj as! NSDictionary)
                        bookingArray.append(bookingParserObj)
                    }
                    self.completionBlockWithSuccess?(url, serverResponse.count > 0 ? 1 : 0, self.requestTag, (bookingArray, nil), nil)
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
    
    func hitNoShowService(appointment: BookingParser, parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/appointments/\(appointment.appointments.first!.id ?? 0)", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSDictionary, statusCode == 200 {
                let bookingParserObj = BookingParser(fromDictionary: serverResponse)
                self.completionBlockWithSuccess?(url, 1 , self.requestTag, (bookingParserObj, nil), dataSaved())
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
    
    func hitCancelBookingService(orderId: String, parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/appointments/\(orderId)/cancel", method: .post, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
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
    
    func hitCreateBookingService(calenderId: String, parameters: String?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitNativeApi("/calendars/\(calenderId)/book", method: .post, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
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
    
    func hitActivatePaymentService(orderId: String, parameters: String?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitNativeApi("/orders/\(orderId)/payments", method: .post, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
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
    
    
}
