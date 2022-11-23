//
//  RideSearchVC.swift
//  EasyRent
//
//  Created by Hitesh on 2022-11-01.
//

import UIKit
import GooglePlaces

class RideSearchVC: UIViewController {
    static let identifier = "RideSearchVC"
    //MARK: IBOutlets
    @IBOutlet weak var tfPlaceSearch: UITextField!
    @IBOutlet weak var tfDistance: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet var radioButtons: [UIButton]!
    @IBOutlet var radioButtonsText: [UIButton]!
    @IBOutlet weak var viewRadioButtons: UIView!
    @IBOutlet weak var tfFrom: UITextField!
    
    //MARK: Vars
    fileprivate var selectedCarType:CarType?
    private var placesClient: GMSPlacesClient!
    fileprivate var startPlace:GMSPlace?

    //MARK: View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    //MARK: Fxns
    fileprivate func setupUI(){
        navigationController?.isNavigationBarHidden = true
        placesClient = GMSPlacesClient.shared()
        getCurrentLocation()
    }
    fileprivate func getCurrentLocation(){
        let placeFields: GMSPlaceField = [.name, .formattedAddress, .coordinate]
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                print("Current place error: \(error?.localizedDescription ?? "")")
                return
            }
            
            guard let place = placeLikelihoods?.first?.place else {
                strongSelf.tfFrom.text = "No current place"
                strongSelf.startPlace = nil
                return
            }
            strongSelf.startPlace = place
            strongSelf.tfFrom.text = place.formattedAddress
        }
    }
    fileprivate func getDistanceInKM(from:CLLocation, to:CLLocation) -> Double {
        let distance = from.distance(from: to)/1000 // in km thus we divide by 1000 so we get it in km
        return distance
    }
    fileprivate func calculatePrice(_ carType:CarType){
        let basePrice = tfDistance.text?.replacingOccurrences(of: " KM", with: "").doubleValue ?? 0.0
        var carTypePrice = 0.0
        switch carType {
        case .sedan:
            carTypePrice = 50.0
        case .luxurySedan:
            carTypePrice = 150.0
        case .suv:
            carTypePrice = 100.0
        }
        tfPrice.text = "$" + "\((basePrice + carTypePrice).clean)"
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
        calculatePrice(selectedCarType!)
    }
    @IBAction func backPressed(_ sender: UIButton) {
        Navigation.instance.pop(vc: self)
    }
    @IBAction func mapPressed(_ sender: UIButton) {
        Navigation.instance.push(to: .MapVC, from: self)
    }
    @IBAction func confirmPressed(_ sender: UIButton) {
    }
    

}

extension RideSearchVC : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField:UITextField) {
        // once textfield starts to begin editing, open the screen where we can enter place to search for
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.placeID.rawValue) | UInt(GMSPlaceField.coordinate.rawValue))
        autocompleteController.placeFields = fields
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        autocompleteController.autocompleteFilter = filter
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
}

extension RideSearchVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        tfPlaceSearch.text = place.name ?? ""
        let currentLoc = CLLocation(latitude: startPlace?.coordinate.latitude ?? 0.0, longitude: startPlace?.coordinate.longitude ?? 0.0)
        let destLoc = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        let distance = getDistanceInKM(from: currentLoc, to: destLoc)
        let cleanedDistance = distance.clean
        tfDistance.text = cleanedDistance + " KM"
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
