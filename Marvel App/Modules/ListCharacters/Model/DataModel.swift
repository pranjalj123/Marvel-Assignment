//
//  DataModel.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import Foundation

struct DataModel : Codable {
    let offset : Int?
    let limit : Int?
    let total : Int?
    let count : Int?
    let results : [ResultsModel]?
    
}
