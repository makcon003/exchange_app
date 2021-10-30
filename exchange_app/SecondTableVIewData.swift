//
//  SecondTableVIewData.swift
//  exchange_app
//
//  Created by Max on 29.10.2021.
//

import Foundation
import UIKit
class SecondTableViewData: NSObject, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exchange2.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! Cell2
       
        return cell

        
    }
}
