//
//  Response.swift
//  JSONSerialization
//
//  Created by Brendan Krekeler on 2/20/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import Foundation

struct Response<Element> {
    enum Status: String {
        case ok
        case error
    }
    
    var status: Response.Status
    var photos: [Element]
    
    init(_ dictionary: [String: Any]) {
        self.status = dictionary["status"] as? Response.Status ?? Response.Status.error
        self.photos = dictionary["photos"] as? [Element] ?? []
    }
    
}
