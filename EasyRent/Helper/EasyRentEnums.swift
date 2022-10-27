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
    case HomeVC, SideMenuVC, ProfileVC, PaymentInfoVC
}

enum Messages : String {
    case chooseOption = "Please choose an option"
    case invalidInput = "Please enter valid input"
    case commonError = "Something went wrong.\nPlease try again after some time"
    case success = "Success"
}

enum ApiEndpoints : String {
    case createUser = "users/create"
    case getAllUsers = "users"
}
