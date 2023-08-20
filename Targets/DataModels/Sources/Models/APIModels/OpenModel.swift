//
//  OpenModel.swift
//  App
//
//  Created by Ozgur Ersoz on 2023-08-20.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation

public struct OpenModel: Decodable {
    public let isOpen: Bool
    public let restaurantId: String
    
    enum CodingKeys: String, CodingKey {
        case isOpen = "is_currently_open"
        case restaurantId = "restaurant_id"
    }
}
