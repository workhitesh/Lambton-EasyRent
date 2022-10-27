//
//  UserModel.swift
//  EasyRent
//
//  Created by Hitesh on 2022-10-26.
//

import Foundation

struct UserModel : Codable {
    let _id : String // required
    let firstName : String // required
    let lastName : String // required
    let profilePic : String? // optional
    let email : String? // optional
    let password : String? // optional
}
