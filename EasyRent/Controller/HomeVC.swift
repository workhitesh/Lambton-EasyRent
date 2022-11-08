//
//  HomeVC.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-12.
//

import UIKit

class HomeVC: UIViewController {
    static let identifier = "HomeVC"
    
    //MARK: IBOutlets
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    @IBOutlet weak var btnSearch: DesignableButton!
    
    //MARK: View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        // adding a target to textfield to trigger everytime something is changed in it
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // invoked everytime something changes in the search field
    @objc func textFieldDidChange(_ textfield:UITextField) {
        let isPostalCodeValid = Utility.isPostalCodeValid((textfield.text ?? "").replacingOccurrences(of: " ", with: ""))
        btnSearch.isHidden = !isPostalCodeValid // if postal code is valid show search button
        if isPostalCodeValid {
            view.endEditing(true)
        }
    }
    
    
    //MARK: IBActions
    @IBAction func searchPressed(_ sender: UIButton) {
        // go to ride search screen
        Navigation.instance.push(to: .RideSearchVC, from: self)
    }
    
    @IBAction func menuTogglePressed(_ sender: UIBarButtonItem) {
        guard let navVC = self.navigationController else {
            return
        }
        Navigation.instance.setupHomeScreen(navVC: navVC)
    }
    
    

}

//MARK: UITextField Delegates
extension HomeVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
}
