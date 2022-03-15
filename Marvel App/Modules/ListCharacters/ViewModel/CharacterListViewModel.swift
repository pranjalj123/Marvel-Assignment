//
//  CharacterListViewModel.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import Foundation
import CryptoKit

    //MARK: ViewModels Protocols
protocol characterListViewModelProtocols : AnyObject {
    func getListOfCharacters()
    func getErrorFrom(err:String)
    func getErrorFromServer()
}

class CharacterListViewModel {
    
    //MARK: Variables
    var characterModel : CharacterModel?
    weak var delegate : characterListViewModelProtocols?
    private var publicKey = getPublicPrivateKeys()[Constants.publicKey.rawValue] ?? ""
    private var privateKey = getPublicPrivateKeys()[Constants.privateKey.rawValue] ?? ""
    
    //MARK: Hit API of get character list from marvel
    func getCharacterList() {
        let ts = String(Int(Date().timeIntervalSinceNow))
        let hash = md5Hash("\(ts)\(privateKey)\(publicKey)")
        let url = "\(baseUrl)characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        APIClass.init().getRequest(url: url, completion: {
            jsonData, error, statuscode in
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
