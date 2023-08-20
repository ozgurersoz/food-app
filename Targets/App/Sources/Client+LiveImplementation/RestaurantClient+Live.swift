//
//  RestaurantClient+Live.swift
//  DataModels
//
//  Created by Ozgur Ersoz on 2023-08-17.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation
import Dependencies
import DataModels

extension RestaurantClient: DependencyKey {
    public static var liveValue: RestaurantClient {
        let restaurantRepository = RestaurantRepository()
        
        return Self(
            fetchRestaurantsWithFilters: {
                var restaurants = try await restaurantRepository.fetchRestaurants()
                let filterItemIds = restaurants.flatMap(\.filterIds).removingDuplicates()
                let filterItems = try await restaurantRepository.fetchFilterItemsWithIdList(filterItemIds)
                restaurants.addTags(from: filterItems)
                return (restaurants, filterItems)                
            },
            fetchRestaurantStatus: { restaurantId in
                try await restaurantRepository.checkRestaurantStatus(withId: restaurantId)
            }
        )
    }
}

