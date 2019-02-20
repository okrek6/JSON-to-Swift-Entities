//
//  Response.swift
//  Codable Protocol
//
//  Created by Brendan Krekeler on 2/19/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import Foundation

struct Response<Element: Codable>: Codable {
    enum Status: String, Codable {
        case ok
        case error
    }
    
    var status: Response.Status
    var photos: [Element]
    
}
