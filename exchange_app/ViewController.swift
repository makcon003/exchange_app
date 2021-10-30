//
//  ViewController.swift
//  exchange_app
//
//  Created by Max on 24.10.2021.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var imageView:UIImage!
    let url = "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"
    let url2 = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == table1
        {
            return exchange.count
        }
        else if tableView == table2{
            return exchange_mi.count
        }
        return 0
        }
   
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        var m = -1
        var n = -1
        if tableView == table1
        {
            for i in exchange_mi
            {
                m+=1
                if i.cc == exchange[indexPath.row].ccy || i.cc == "RUB" && exchange[indexPath.row].ccy == "RUR"
                {
                    let indexPath1 = IndexPath(row: m,section: 0)
                    table2.selectRow(at: indexPath1, animated: false, scrollPosition: UITableView.ScrollPosition.middle)
                    
                }
                
            }
                    
    }else if tableView == table2
    {
        for i in exchange
        {
            n+=1
            if i.ccy == exchange_mi[indexPath.row].cc || i.ccy == "RUR" && exchange_mi[indexPath.row].cc == "RUB"
            {
                let indexPath2 = IndexPath(row: n,section: 0)
                table1.selectRow(at: indexPath2, animated: false, scrollPosition: UITableView.ScrollPosition.middle)
            }
        }
        
    }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == table1
        {
        return 70
    } else if tableView == table2
        {
        return 40
    }
        return 0
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == table1
        {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell
            {
        cell.buy.text = exchange[indexPath.row].buy
        cell.sale.text = exchange[indexPath.row].sale
        cell.imagename.image  = (imageWith(name:exchange[indexPath.row].ccy))
            return cell
        }
            else{
                let cell = CustomCell.init(style: .value2, reuseIdentifier: "CustomCell")
                cell.buy.text = exchange[indexPath.row].buy
                cell.sale.text = exchange[indexPath.row].sale
                cell.imagename.image  = (imageWith(name:exchange[indexPath.row].ccy))
                return cell
            }
        }
        else if tableView == table2
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as? Cell2
            {
                cell.descr.text = exchange_mi[indexPath.row].txt
               cell.buy.text = String(exchange_mi[indexPath.row].rate)
                
                
                return cell
        }
            else
            {
                let cell = Cell2.init(style: .value1, reuseIdentifier: "Cell2")
                cell.descr.text = exchange_mi[indexPath.row].txt
               cell.buy.text = String(exchange_mi[indexPath.row].rate)
                
                
                return cell
                
        }
        }
        return UITableViewCell()
    }
        
    func imageWith(name: String?) -> UIImage? {
         let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
         let nameLabel = UILabel(frame: frame)
         nameLabel.textAlignment = .center
         nameLabel.backgroundColor = .black
         nameLabel.textColor = .white
         nameLabel.font = UIFont.boldSystemFont(ofSize: 40)
         nameLabel.text = name
         UIGraphicsBeginImageContext(frame.size)
          if let currentContext = UIGraphicsGetCurrentContext() {
             nameLabel.layer.render(in: currentContext)
             let nameImage = UIGraphicsGetImageFromCurrentImageContext()
             return nameImage
          }
          return nil
    }
    func loadJson(completed: @escaping ()->()){
        AF.request(url2).responseData(completionHandler : { (response) in
                switch response.result {
                case .success( let data):

                    do {
                        self.exchange_mi = try JSONDecoder().decode([MijBank].self, from: data)
                        DispatchQueue.main.async {
                            completed()
                        }
                    }
                    catch {print(error)}

                case .failure(let error):
                    print (error)
                }

            })
    }
    
    func updateJson(completed: @escaping ()->()){
        AF.request(url).responseData(completionHandler : { (response) in
                switch response.result {
                case .success( let data):

                    do {
                        self.exchange = try JSONDecoder().decode([Exchange].self, from: data)
                        DispatchQueue.main.async {
                            completed()
                        }
                    }
                    catch {print(error)}

                case .failure(let error):
                    print (error)
                }

            })
    }

    
    @IBOutlet var table1: UITableView!
    var exchange = [Exchange]()
    var exchange_mi = [MijBank]()
    @IBOutlet var table2: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        updateJson{ self.table1.reloadData() }
        loadJson{ self.table2.reloadData() }
        table1.dataSource = self
        table1.delegate = self
        table2.dataSource = self
        table2.delegate = self

    }


}

