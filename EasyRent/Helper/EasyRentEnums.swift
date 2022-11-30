//
//  EasyRentEnums.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-12.
//

import UIKit

enum UserDefaultKeys:String {
    case isLogin, userId
}

enum Controllers : String {
    case HomeVC, SideMenuVC, ProfileVC, PaymentInfoVC, RideSearchVC, MapVC
}

enum Messages : String {
    case chooseOption = "Please choose an option"
    case invalidInput = "Please enter valid input"
    case commonError = "Something went wrong.\nPlease try again after some time"
    case success = "Success"
    case noDestination = "Please choose a destination first."
    case noPath = "No route found to your destination."
}

enum ApiEndpoints : String {
    case createUser = "users/create"
    case getAllUsers = "users"
    case addCreditCard = "credit/create"
    case getCardById = "credit/getAll/"
    case getUserById = "users/"
}

enum CarType : Int {
    case sedan = 0
    case luxurySedan = 1
    case suv = 2
}

extension UIImage {
    static let radioSelected = UIImage(named: "radio-selected")!
    static let radioUnselected = UIImage(named: "radio-unselected")!
}
