//
//  CharacterListTableViewCell.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import UIKit

class CharacterListTableViewCell: UITableViewCell {

    //MARK: IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var characterImageView: CustomImageView!
    
    //MARK: Variables
    static let nib = UINib.init(nibName: "CharacterListTableViewCell", bundle: nil)
    static let indent = "CharacterListTableViewCell"
    
    //MARK: Cell cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: Assign data from model to cell
    func bindData(model : ResultsModel?) {
        guard let model = model else {
            return
        }
        if model.description ?? "" == "" {
            self.descriptionLabel.isHidden = true
        } else {
            self.descriptionLabel.isHidden = false
        }
        
        self.descriptionLabel.text = model.description
        self.titleLabel.text = model.name
        let urlString = (model.thumbnail?.path ?? "") + "." + (model.thumbnail?.extensionImage ?? "")
        self.characterImageView.downloadImageFrom(urlString: urlString, imageMode: .scaleAspectFill)
    }
    
    
    
}
