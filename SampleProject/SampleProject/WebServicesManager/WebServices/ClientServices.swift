//
//  ClientServices.swift
//  Bokadirekt
//
//  Created by Money Mahesh on 26/11/18.
//  Copyright © 2018 quarks. All rights reserved.
//

import Foundation
import Alamofire

class ClientServices: MBAlamofireServerConnect {
    
    func hitClientListService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/customers?", method: .get, parameters: parameters, encoding: URLEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSArray {
                
                if serverResponse.count > 0 {
                
                    var clientArray = [ClientParser]()
                    for obj in serverResponse {
                        let clientParserObj = ClientParser(fromDictionary: obj as! NSDictionary)
                        clientArray.append(clientParserObj)
                        print(clientParserObj.email ?? "NA")
                    }
                    self.completionBlockWithSuccess?(url, serverResponse.count > 0 ? 1 : 0, self.requestTag, (clientArray, nil), nil)
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
    
    
    func hitAddClientService(parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/customers?", method: .post, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSDictionary, statusCode == 200 {
                let clientObj: ClientParser = ClientParser(fromDictionary: serverResponse)
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (clientObj, nil), dataSaved())
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
    
    func hitSaveClientService(customerId : Int, parameters: [String: Any]?, additionalHeaderElements: [String: String]?) {
        
        let _ = MBAlamofireServerConnect.requestOperationManager.hitApiArrayResp("/customers/\(customerId)", method: .patch, parameters: parameters, encoding: JSONEncoding.default, headerElements: additionalHeaderElements, success: {(statusCode: Int, url : String? , responseObject: Any) in
            
            let serverResponse = self.processAfterMakingRequestWithParameters(responseObject)
            if let serverResponse = serverResponse as? NSDictionary, statusCode == 200 {
                let clientObj: ClientParser = ClientParser(fromDictionary: serverResponse)
                self.completionBlockWithSuccess?(url, 1, self.requestTag, (clientObj, nil), dataSaved())
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
