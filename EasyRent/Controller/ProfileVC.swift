//
//  ProfileVC.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-19.
//

import UIKit

class ProfileVC: UIViewController {
    static let identifier = "ProfileVC"
    
    //MARK: IBOutlets
    @IBOutlet weak var imgUser: DesignableImageView!
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns
    fileprivate func setupUI(){
        // hide default top navigation bar
        navigationController?.isNavigationBarHidden = true
    }
    
    
    //MARK: IBActions
    @IBAction func editPhotoPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        Navigation.instance.pop(vc: self)
    }
    
}
