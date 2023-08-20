//
//  RestaurantModel.swift
//  DataModels
//
//  Created by Ozgur Ersoz on 2023-08-17.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation

public struct RestaurantModel: Decodable, Identifiable {
    public let id: String
    public let deliveryTimeMinutes: Int
    public let rating: Double
    public let imageURL: URL?
    public let name: String
    public let filterIds: [String]
    public var tags: [String] = []
    public var visible: Bool = true
    
    enum CodingKeys: String, CodingKey {
        case deliveryTimeMinutes = "delivery_time_minutes"
        case rating
        case imageURL = "image_url"
        case name
        case filterIds
        case id
    }
    
    public mutating func setVisibility(visible: Bool) {
        self.visible = visible
    }
    
    mutating func addTags(_ tags: [String]) {
        self.tags = tags
    }
}

extension Array where Element == RestaurantModel {
    public mutating func addTags(from filterItems: [FilterModel]) {
        self = map { restaurant in
            var mutableRestaurant = restaurant
            let tags = restaurant.filterIds.compactMap { restaurantFilterId -> String? in
                return filterItems.first(where: { $0.id == restaurantFilterId }).map(\.name)
            }
            mutableRestaurant.addTags(tags)
            return mutableRestaurant
        }
    }
}

