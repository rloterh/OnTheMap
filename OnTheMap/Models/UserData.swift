//
//  UserData.swift
//  OnTheMap
//
//  Created by Admin on 17/04/2020.
//  Copyright © 2020 com.robert.loterh. All rights reserved.
//

import Foundation

struct UserData: Codable {
    let firstName: String
    let lastName: String
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case key
    }
}
