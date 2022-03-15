//
//  CharacterModel.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import Foundation

struct CharacterModel : Codable {
    let data : DataModel?
    let status : String?
}

struct ErrorModel : Codable {
    let code : String?
    let message : String?
}
