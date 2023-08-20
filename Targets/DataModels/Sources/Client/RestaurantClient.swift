//
//  RestaurantClient.swift
//  App
//
//  Created by Ozgur Ersoz on 2023-08-17.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Dependencies

public struct RestaurantClient {
    public var fetchRestaurantsWithFilters: () async throws -> (restaurants: [RestaurantModel], filterItems: [FilterModel])
    public var fetchRestaurantStatus: (_ restaurantId: String) async throws -> OpenModel
    
    public init(
        fetchRestaurantsWithFilters: @escaping () async throws -> (restaurants: [RestaurantModel], filterItems: [FilterModel]),
        fetchRestaurantStatus: @escaping (_ restaurantId: String) async throws -> OpenModel
    ) {
        self.fetchRestaurantsWithFilters = fetchRestaurantsWithFilters
        self.fetchRestaurantStatus = fetchRestaurantStatus
    }
}

extension RestaurantClient: TestDependencyKey {
    public static var testValue: RestaurantClient {
        Self(
            fetchRestaurantsWithFilters: {
                return (MockData.restaurants, MockData.filterItems)
            },
            fetchRestaurantStatus: { _ in
                return .init(isOpen: true, restaurantId: "randomId")
            }
        )
    }
    
    public static var previewValue: RestaurantClient {
        Self(
            fetchRestaurantsWithFilters: {
                return (MockData.restaurants, MockData.filterItems)
            },
            fetchRestaurantStatus: { _ in
                return .init(isOpen: true, restaurantId: "randomId")
            }
        )
    }
}

extension DependencyValues {
    public var restaurantClient: RestaurantClient {
        get { self[RestaurantClient.self] }
        set { self[RestaurantClient.self] = newValue }
    }
}
