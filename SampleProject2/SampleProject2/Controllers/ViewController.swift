//
//  ViewController.swift
//  SampleProject2
//
//  Created by Saurabh on 11/07/19.
//  Copyright © 2019 Saurabh. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var placeVM = PlaceViewModel()
    
    lazy var tableView : UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.estimatedRowHeight = 100
        t.rowHeight = UITableView.automaticDimension
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // To get Places Json from URL
        getPlaces()
    }
    
    private func setupUI() {
        //  To setup the UI of the TableView
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        tableView.register(PlaceCell.self, forCellReuseIdentifier: Cells.place)
        tableView.dataSource = self
        tableView.addRefreshControll(actionTarget: self, action: #selector(refreshPlaces))
        self.view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func getPlaces() {
        let activityIndicator = ActivityIndicator.shared
        activityIndicator.animateActivity(title: "Loading...", view: self.view, navigationItem: navigationItem)
        
        placeVM.fetchPlaces {
            DispatchQueue.main.async {
                self.navigationItem.title = self.placeVM.setNaigationTitle()
                self.tableView.reloadData()
                activityIndicator.stopAnimating(navigationItem: self.navigationItem)
            }
        }
    }
}

extension ViewController {
    @objc func refreshPlaces(_ refreshControl: UIRefreshControl) {
        tableView.endRefreshing(deadline: .now() + .seconds(3))
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeVM.numberOfItemInSection(section: section) 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.place, for: indexPath) as! PlaceCell
        configureCell(cell: cell, forRowIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: PlaceCell, forRowIndexPath indexPath: IndexPath) {
        cell.titleLabel.text = placeVM.titleForItemAtIndexPath(indexPath: indexPath)
        cell.descriptionLabel.text = placeVM.descriptionForItemAtIndexPath(indexPath: indexPath)
        placeVM.setImage(cell: cell, indexPath: indexPath)
    }
}
