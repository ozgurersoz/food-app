//
//  RestaurantsViewModel.swift
//  App
//
//  Created by Ozgur Ersoz on 2023-08-17.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation
import DataModels
import Dependencies

public class RestaurantsViewModel: ObservableObject {
    @Dependency(\.restaurantClient) var restaurantClient
    
    @Published var restaurants: [RestaurantModel] = []
    @Published var filterItems: [FilterModel] = []
    @Published var selectedResturant: RestaurantModel?
    @Published var presentedError: ErrorModel?
    
    public init() { }
        
    @MainActor
    func fetchRestaurants() async {
        do {
            (restaurants, filterItems) = try await restaurantClient.fetchRestaurantsWithFilters()
        } catch NetworkError.errorModel(let errorModel) {
            presentedError = errorModel
        } catch {
            presentedError = ErrorModel(reason: "Unexpected error: \(error.localizedDescription)")
        }
        return
    }
    
    func prepareFilteredData(byFilterId id: String) {
        filterItems = filterItems.map { filterItem in
            var mutableFilterItem = filterItem
            if filterItem.id == id {
                mutableFilterItem.setSelected(filterItem.selected ? false : true)
            }
            return mutableFilterItem
        }
        prepareFilteredRestaurants()
    }
    
    private func prepareFilteredRestaurants() {
        restaurants = restaurants.map { restaurant in
            var mutableRestaurant = restaurant
            let selectedFilterItems = filterItems.filter ({ $0.selected }).map(\.id)
            if Set(selectedFilterItems).isSubset(of: restaurant.filterIds) {
                mutableRestaurant.setVisibility(visible: true)
            } else {
                mutableRestaurant.setVisibility(visible: false)
            }
            return mutableRestaurant
        }
    }
}
