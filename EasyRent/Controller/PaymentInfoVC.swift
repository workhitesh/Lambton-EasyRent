//
//  PaymentInfoVC.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-19.
//

import UIKit

class PaymentInfoVC: UIViewController {
    static let identifier = "PaymentInfoVC"
    
    //MARK: IBOutlets
    @IBOutlet weak var tfExpiryDate: UITextField!
    @IBOutlet weak var tfCardNumber: UITextField!
    
    //MARK: Vars
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker(frame: .zero)
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        datePicker.timeZone = TimeZone.current
        return datePicker
    }()
    
    //MARK: View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
   
    //MARK: Fxns
    fileprivate func setupUI(){
        navigationController?.isNavigationBarHidden = true
        tfExpiryDate.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
        getMyCardInfo()
    }
    
    fileprivate func getMyCardInfo(){
        guard let myUserId = Utility.getUD(.userId) as? String else {
            return
        }
        Webservices.instance.get(url: API_BASE_URL+ApiEndpoints.getCardById.rawValue+myUserId, params: nil) { success, response, error in
            if success {
                if let cards = response as? NSArray, cards.count > 0 {
                    let myCard = cards[0] as AnyObject
                    if let cardNumber = myCard["cardNumber"] as? Int, let expiry = myCard["expiry"] as? String {
                        self.tfCardNumber.text = "\(cardNumber)"
                        self.tfExpiryDate.text = expiry
                    }
                } else {
//                    Utility.showAlert(with: .commonError, on: self)
                }
            } else {
//                Utility.showAlert(with: .commonError, on: self)
            }
        }
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "MM/YYYY"
        tfExpiryDate.text = dateFormatter.string(from: sender.date)
     }
    
    //MARK: IBActions
    @IBAction func backPressed(_ sender: UIButton) {
        Navigation.instance.pop(vc: self)
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        // validations
        guard let cardNumber = tfCardNumber.text, let expiry = tfExpiryDate.text else {
            Utility.showAlert(with: .invalidInput, on: self)
            return
        }
        if cardNumber.isValidCreditCard {
            // call api to save card
            guard let myUserId = Utility.getUD(.userId) as? String else {
                return
            }
            let params = ["ownerId":myUserId,"cardNumber":cardNumber,"expiry":expiry] as [String:Any]
            Utility.showLoader(on: self)
            Webservices.instance.post(url: API_BASE_URL+ApiEndpoints.addCreditCard.rawValue, params: params) { success, response, error in
                Utility.hideLoader(from: self)
                if success {
                    Utility.showAlert(with: .success, on: self)
                } else {
                    Utility.hideLoader(from: self)
                    Utility.showAlert(with: .commonError, on: self)
                }
            }
        } else {
            Utility.showAlert(with: .invalidInput, on: self)
        }
    }
}
