//
//  JSON2.swift
//  exchange_app
//
//  Created by Max on 29.10.2021.
//

import Foundation

class MijBank: Decodable{
    var r030: Int
    var txt: String
    var rate: Float
    var cc:  String
    var exchangedate: String
    
}
