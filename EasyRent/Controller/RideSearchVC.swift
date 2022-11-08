//
//  RideSearchVC.swift
//  EasyRent
//
//  Created by Hitesh on 2022-11-01.
//

import UIKit

class RideSearchVC: UIViewController {
    static let identifier = "RideSearchVC"
    //MARK: IBOutlets
    @IBOutlet weak var tfPlaceSearch: UITextField!
    @IBOutlet weak var tfDistance: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet var radioButtons: [UIButton]!
    @IBOutlet var radioButtonsText: [UIButton]!
    @IBOutlet weak var viewRadioButtons: UIView!
    
    //MARK: Vars
    fileprivate var selectedCarType:CarType?

    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    //MARK: Fxns
    fileprivate func setupUI(){
        navigationController?.isNavigationBarHidden = true
    }
    //MARK:IBActions
    @IBAction func carCategorySelected(_ sender: UIButton) {
        // logic to select a car category based on sender(button) tags
        let tappedTag = sender.tag
        for case let btn as UIButton in viewRadioButtons.subviews {
            if btn.tag < 200 {
                btn.setBackgroundImage(.radioUnselected, for: .normal)
            }
            if btn.tag == sender.tag || (btn.tag == tappedTag - 100) {
                if btn.tag < 200 {
                    btn.setBackgroundImage(.radioSelected, for: .normal)
                }
            }
        }
        if tappedTag == 100 || (tappedTag - 100 == 100) {
            selectedCarType = .sedan
        } else if tappedTag == 101 || (tappedTag - 100 == 101) {
            selectedCarType = .luxurySedan
        } else {
            selectedCarType = .suv
        }
    }
    @IBAction func backPressed(_ sender: UIButton) {
        Navigation.instance.pop(vc: self)
    }
    @IBAction func mapPressed(_ sender: UIButton) {
    }
    @IBAction func confirmPressed(_ sender: UIButton) {
    }
    

}
