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
    
    var saurString: String?
    
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
        view.backgroundColor = .white
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
        
        let margins = view.safeAreaLayoutGuide
        tableView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
    }
    
    private func getPlaces() {
        placeVM.fetchPlaces { (error) in
            print(error?.localizedDescription ?? No_Error)
            DispatchQueue.main.async {
                self.navigationItem.title = self.placeVM.setNaigationTitle()
                self.tableView.reloadData()
                TableViewHelper.EmptyMessage(message: error?.localizedDescription ?? Loading_Title, table: self.tableView)
            }
        }
    }
}

extension ViewController {
    @objc func refreshPlaces(_ refreshControl: UIRefreshControl) {
        getPlaces()
        tableView.endRefreshing(deadline: .now() + .seconds(2))
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if placeVM.numberOfItemInSection(section: section) > 0 {
            return placeVM.numberOfItemInSection(section: section)
        }else {
            TableViewHelper.EmptyMessage(message: No_Data, table: tableView)
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.place, for: indexPath) as! PlaceCell
        configureCell(cell: cell, forRowIndexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: PlaceCell, forRowIndexPath indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.titleLabel.text = placeVM.titleForItemAtIndexPath(indexPath: indexPath)
        cell.descriptionLabel.text = placeVM.descriptionForItemAtIndexPath(indexPath: indexPath)
        placeVM.setImage(cell: cell, indexPath: indexPath)
    }
}
