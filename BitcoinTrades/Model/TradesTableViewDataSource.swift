//
//  TradesTableViewDataSource.swift
//  BitcoinTrades
//
//  Created by Pawel Jurczyk on 24/10/2019.
//  Copyright © 2019 Pawel Jurczyk. All rights reserved.
//

import UIKit

class TradesTableViewDataSource: NSObject, UITableViewDataSource {
    
    private static let cellIdentifier = "Cell"
    
    var cellModels = [CellModel]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[cellModels.count - indexPath.row - 1]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: TradesTableViewDataSource.cellIdentifier)
        
        cell.textLabel?.text = cellModel.text
        cell.detailTextLabel?.text = cellModel.detailText
        cell.backgroundColor = cellModel.backgroundColor
        
        return cell
    }
}
