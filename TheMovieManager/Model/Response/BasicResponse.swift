//
//  BasicResponse.swift
//  TheMovieManager
//
//  Created by Ricardo Bravo on 26/06/21.
//  Copyright © 2021 Udacity. All rights reserved.
//

import Foundation

struct BasicResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
}
