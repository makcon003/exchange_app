//
//  JSON.swift
//  exchange_app
//
//  Created by Max on 24.10.2021.
//

import Foundation

struct Exchange : Decodable {
    var ccy: String
    var base_ccy: String
    var buy: String
    var sale: String
}

