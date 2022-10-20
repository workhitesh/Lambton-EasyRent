//
//  SideMenuVC.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-12.
//

import UIKit

class SideMenuVC: UIViewController {
    static let identifier = "SideMenuVC"

    //MARK: IBOutlets
    
    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: Fxns

    //MARK: IBActions
    @IBAction func profilePressed(_ sender: UIButton) {
        Navigation.instance.push(to: .ProfileVC, from: self)
    }
    
    @IBAction func paymentPressed(_ sender: UIButton) {
        Navigation.instance.push(to: .PaymentInfoVC, from: self)
    }
    
}
