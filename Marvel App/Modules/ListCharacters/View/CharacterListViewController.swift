//
//  CharacterListViewController.swift
//  Marvel App
//
//  Created by admin on 3/13/22.
//

import UIKit

class CharacterListViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var listTableView: UITableView!
    
    //MARK: Variables
    var characterListViewModel = CharacterListViewModel()
    var progressLoader : UIActivityIndicatorView?
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.characterListViewModel.delegate = self
        self.listTableView.register(CharacterListTableViewCell.nib, forCellReuseIdentifier: CharacterListTableViewCell.indent)
        self.setActivityIndicator()
        self.characterListViewModel.getCharacterList()
    }
    
    //MARK: Set activity indicator on screen
    func setActivityIndicator() {
        progressLoader = ActivityProgressView.indicator(at: self.view.center)
        self.view.addSubview(progressLoader!)
        progressLoader?.startAnimating()
    }
    
    //MARK: Show alert on screen
    func showAlertView(title : String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


//MARK: UITableViewDelegate, UITableViewDatasource
extension CharacterListViewController :
    UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.characterListViewModel.characterModel?.data?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterListTableViewCell.indent) as! CharacterListTableViewCell
        cell.bindData(model: self.characterListViewModel.characterModel?.data?.results?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewControllerInstance = CharacterDetailViewController.instance()
        viewControllerInstance.detailViewModel = CharacterDetailViewModel.init(id:"\(self.characterListViewModel.characterModel?.data?.results?[indexPath.row].id ?? 0)")
        self.navigationController?.pushViewController(viewControllerInstance, animated: true)
    }
}

//MARK: Navigation extension
extension CharacterListViewController {
    class func instance() -> CharacterListViewController {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: "CharacterListViewController") as! CharacterListViewController
    }
    
    class func navigation() -> UINavigationController {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        return mainStoryboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
    }
}

//MARK: ViewModel protocols
extension CharacterListViewController: characterListViewModelProtocols {
    func getListOfCharacters() {
        self.progressLoader?.removeFromSuperview()
        self.listTableView.reloadData()
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


