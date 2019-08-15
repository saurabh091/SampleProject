//
//  Webservice.swift
//  SampleProject2
//
//  Created by Saurabh on 11/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//
// Test
import Foundation
import UIKit

class Webservice {
    
    static let sharedInstance = Webservice()
    private let placeURL = URL(string: JSON_Url)!
    
    func loadSources(completion :@escaping (Place?, Error?) -> ()) {
        URLSession.shared.dataTask(with: placeURL) { data, _, error in

            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let place = try decoder.decode(Place.self, from: data)
                    print(place.title ?? "no value")
                    DispatchQueue.main.async {
                        completion(place, nil)
                    }
                } catch let err {
                    print("Err", err)
                    DispatchQueue.main.async {
                        completion(nil, err)
                    }
                }
            }
            }.resume()
    }
    
}
