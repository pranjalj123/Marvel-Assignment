//
//  CharacterDetailViewController.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import UIKit

class CharacterDetailViewController: ParentViewController {

    //MARK: IBOutlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var marvelImageView: CustomImageView!
    
    //MARK: Variables
    var detailViewModel : CharacterDetailViewModel?
    
    //MARK: VIewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailViewModel?.delegate = self
        self.setActivityIndicator()
        self.detailViewModel?.getCharacterDetailAPI()
        
    }
    
    //MARK: Set data from API to outlets
    func setData() {
        guard let resultsArray = detailViewModel?.characterModel?.data?.results else {
            return
        }
        
        if resultsArray.count > 0 {
            self.descriptionLabel.text = resultsArray[0].description
            self.titleLabel.text = resultsArray[0].name
            let urlString = (resultsArray[0].thumbnail?.path ?? "") + "." + (resultsArray[0].thumbnail?.extensionImage ?? "")
            self.marvelImageView.downloadImageFrom(urlString: urlString, imageMode: .scaleToFill)
        }
    }

}


//MARK: Navigation extension
extension CharacterDetailViewController {
    class func instance() -> CharacterDetailViewController {
        let detailStoryBoard = UIStoryboard.init(name: "Detail", bundle: nil)
        return detailStoryBoard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
    }
}

//MARK: USe of CharacterDetailViewModelProtocol
extension CharacterDetailViewController : CharacterDetailViewModelProtocol {
   
    
    func getListOfCharacters() {
        self.progressLoader?.removeFromSuperview()
        self.setData()
    }
    
    func getErrorFrom(err: String) {
        self.progressLoader?.removeFromSuperview()
        self.showAlertView(title: error, message: err)
    }
    
    func getErrorFromServer() {
        self.progressLoader?.removeFromSuperview()
        self.showAlertView(title: error, message: serverMsg)
    }
}
