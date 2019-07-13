//
//  Constants.swift
//  SampleProject2
//
//  Created by Saurabh on 11/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import Foundation

let PlaceHolder_Image   =   "placeholder"
let Refresh_Title       =   "Pull to refresh"
let No_Error            =   "No Error"
let Loading_Title       =   "Loading Places...."
let No_Data     =   "No data available, Pull to refresh"
//let JSON_Url          =   "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

/*
 // Above mentioned URL was throwing some error regarding JSON Parsing at last lines there i edit the above json and take the top json Part remove last json and upload in below url.
 
 //Alamofire.AFError.ResponseSerializationFailureReason.jsonSerializationFailed(error: Error Domain=NSCocoaErrorDomain Code=3840 "Unable to convert data to string around character 2643." UserInfo={NSDebugDescription=Unable to convert data to string around character 2643.}))
 
 Therefore i just copied th JSON inside it and create new link mentioned below, you can check the content.
 
 */

let JSON_Url            =   "https://api.myjson.com/bins/iij5n"

struct Cells {
    static let place    =   "PlaceCell"
}
