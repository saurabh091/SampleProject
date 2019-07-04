import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class APiManager: NSObject {
    
    static let sharedInstance = APiManager()
    
    //TODO :-
    /* Handle Time out request alamofire */
    func Get(url: String, viewController: UIViewController, completion: @escaping (_ data: JSON?) -> Void) {
        
    
        Alamofire.request(url, method: .get, parameters: nil).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                
                let error: Error = response.result.error!
                AlertMaker().alert(info: error.localizedDescription  , viewController: viewController)
                completion(nil)
                return
            }
            guard let Json = response.result.value as? [String: Any] else {
                AlertMaker().alert(info: errorMsg.JsonConvert, viewController: viewController)
                completion(nil)
                return
            }
            
            
            completion(JSON(Json))
        }
    }
    
    func requestGETURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void)
    {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            //print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                //let title = resJson["title"].string
                //print(title!)
                success(resJson)
            }
            
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    func requestGETURLFromQuery(_ strURL: String, parameter: Parameters, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void)
    {
        let _url = strURL
        let headers: HTTPHeaders = [
            "X-UserName": "test@bokadirekt.se",
            "X-Role": "Subscriber"
        ]
        Alamofire.request(_url, method: .get, parameters: parameter, encoding: URLEncoding.queryString, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                //let title = resJson["title"].string
                //print(title!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            //print(responseObject)
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
}
