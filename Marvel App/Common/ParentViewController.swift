//
//  ViewController.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import UIKit
import AVFoundation


//This is the parent class of UIViewController.
class ParentViewController: UIViewController {

    //MARK: Generate hash from cryptokit
    var progressLoader : UIActivityIndicatorView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: Set activity indicator on screen
    func setActivityIndicator() {
        progressLoader = ActivityProgressView.indicator(at: self.view.center)
        self.view.addSubview(progressLoader!)
        progressLoader?.startAnimating()
    }
    
    //MARK: Show alert on screen
    func showAlertView(title : String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
            (result : UIAlertAction) -> Void in
            
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

