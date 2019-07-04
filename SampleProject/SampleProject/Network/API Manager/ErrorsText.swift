//
//  ErrorsText.swift
//  MLIPIA
//
//  Created by Orange Mantra on 01/04/19.
//  Copyright © 2019 OrangeMantra. All rights reserved.
//

import Foundation
import UIKit

class AlertMaker {
    func alert(info:String, viewController: UIViewController) {
        let popUP = UIAlertController(title: nil, message: info, preferredStyle: .alert)
        popUP.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
            popUP.dismiss(animated: true, completion: nil)
        }))
        viewController.present(popUP, animated: true, completion: nil)
    }
    
// Error Response
    func errorResponseAlert(viewcontroller:UIViewController, description: String) {
        let alert = UIAlertController(title: "", message: description, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive, handler: nil)
        alert.addAction(action)
        viewcontroller.present(alert, animated: true, completion: nil)
    }
}

enum errorMsg {
    static let Internet = "No Internet connection Please Check Your Internet Connections."
    static let JsonConvert = "Something went wrong Please check and try again."
    static let loanDetailsError = "Loan Details Error."
    static let miniStatementError = "No Data Found Please do some transaction first."
}
