//
//  UserModel.swift
//  OrienPay
//
//  Created by Buzurg Rakhımzoda on 30.06.2023.
//

import Foundation

struct User: Hashable, Codable, Identifiable{
    let id: Int
    var name: String
    var surname: String
    let phone_numbers: String
    var age: String
    var authorized: Bool
}
