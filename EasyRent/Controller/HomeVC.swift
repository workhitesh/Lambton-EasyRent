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
    @IBOutlet weak var btnSearch: DesignableButton!
    
    //MARK: View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        tfSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textfield:UITextField) {
        let isPostalCodeValid = Utility.isPostalCodeValid((textfield.text ?? "").replacingOccurrences(of: " ", with: ""))
        btnSearch.isHidden = !isPostalCodeValid
    }
    
    
    //MARK: IBActions
    @IBAction func searchPressed(_ sender: UIButton) {
        
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
