//
//  ViewController.swift
//  SampleProject
//
//  Created by Saurabh on 03/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let cellId = "cellId"
    var apiData: Place?
    
    lazy var tableView : UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.estimatedRowHeight = 300
        t.rowHeight = UITableView.automaticDimension
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callApi()
        setupUI()
    }
    
    func getApiCall() {
        Alamofire.request(BaseURl).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Validation Successful)")
                
                if let json = response.data {
                    do{
                        let data = try JSON(data: json)
                        let str = data["headers"]["Host"]
                        print("DATA PARSED: \(str)")
                    }
                    catch{
                        print("JSON Error")
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController {
    func setupUI() {
        tableView.register(PlaceCell.self, forCellReuseIdentifier: cellId)
        self.view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        // set delegate and datasource
        tableView.dataSource = self
        
        // register a defalut cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiData == nil ? 0 : ((apiData?.rows!.count)!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PlaceCell
        cell.placeRow = apiData?.rows![indexPath.row]
        return cell
    }
}

extension ViewController {
    func callApi() {
        APiManager().Get(url: BaseURl, viewController: self) { (jsonValue) in
            guard let json = jsonValue else { return }
            print(json)
            self.apiData = try? JSONDecoder().decode(Place.self, from: jsonValue!.rawData())
            self.navigationItem.title = self.apiData?.title
            self.tableView.reloadData()
        }
    }
}



