//
//  CharacterDetailViewModel.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import Foundation
import CryptoKit

//MARK: CharacterDetailViewModelProtocol Methods
protocol CharacterDetailViewModelProtocol : AnyObject {
    func getListOfCharacters()
    func getErrorFrom(err:String)
    func getErrorFromServer()
}

class CharacterDetailViewModel {
    //MARK: Variables
    var characterModel : CharacterModel?
    weak var delegate : CharacterDetailViewModelProtocol?
    private var publicKey = getPublicPrivateKeys()[Constants.publicKey.rawValue] ?? ""
    private var privateKey = getPublicPrivateKeys()[Constants.privateKey.rawValue] ?? ""
    var characterId:String?
    
    //MARK: Initializer
    init(id:String) {
        self.characterId = id
    }
    
    //MARK: Hit API of DetailCharater
    func getCharacterDetailAPI() {
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters/\(self.characterId ?? "")?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getRequest(url: url, completion: { jsonData, error, statuscode in
            if let error = error {
                self.delegate?.getErrorFrom(err: error.localizedDescription)
                return
            }
            
            if let statuscode = statuscode {
                if statuscode == 200 {
                    let jsonDecoder = JSONDecoder()
                    self.characterModel = try? jsonDecoder.decode(CharacterModel.self, from: jsonData!)
                    self.delegate?.getListOfCharacters()
                } else {
                    self.delegate?.getErrorFromServer()
                }
            }
        })
    }
}
