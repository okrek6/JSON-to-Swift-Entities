//
//  Photo.swift
//  Codable Protocol
//
//  Created by Brendan Krekeler on 2/19/19.
//  Copyright © 2019 Brendan Krekeler. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let image: String
    let title: String
    let description: String
    let latitude: Double
    let longitude: Double
    let date: String
}
