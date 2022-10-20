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
        
    }
}
