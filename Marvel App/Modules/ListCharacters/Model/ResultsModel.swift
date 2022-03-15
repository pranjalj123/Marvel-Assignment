//
//  ResultsModel.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import Foundation

struct ResultsModel : Codable {
    let id : Int?
    let name : String?
    let description : String?
    let thumbnail : ThumbnailModel?
}
