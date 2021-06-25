//
//  Login.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let username: String
    let pwd: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case pwd = "password"
        case requestToken = "request_token"
    }
}
