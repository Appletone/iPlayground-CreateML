//
//  StationListTableViewController.swift
//  MRTTrafficDemo
//
//  Created by Louis.Chang on 2018/10/17.
//  Copyright © 2018 Louis Chang. All rights reserved.
//

import UIKit

enum ListType {
    case inbound
    case outbound
}

class StationListTableViewController: UITableViewController {
    var input:MRTInput?
    var type:ListType = .inbound
    var dataSource = Constants.StationList
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let name = dataSource[indexPath.row]
        // Configure the cell...
        cell.textLabel?.text = String(name)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let input = self.input else {return}
        
        let name = dataSource[indexPath.row]
        
        switch type {
        case .inbound:
            input.Inbound = String(name)
        case .outbound:
            input.Outbound = String(name)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
