//
//  PostLocationResponse.swift
//  OnTheMap
//
//  Created by Admin on 17/04/2020.
//  Copyright © 2020 com.robert.loterh. All rights reserved.
//

import Foundation

struct PostLocationResponse: Codable {
    let createAt: String
    let objectId: String
    
    enum CodingKeys: String, CodingKey {
        case createAt
        case objectId
    }
}
