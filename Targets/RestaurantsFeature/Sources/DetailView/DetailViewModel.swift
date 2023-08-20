//
//  DetailViewModel.swift
//  App
//
//  Created by Ozgur Ersoz on 2023-08-20.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation
import Dependencies
import DataModels

class DetailViewModel: ObservableObject, Identifiable {
    @Dependency(\.restaurantClient) var restaurantClient
    
    @Published var presentedError: ErrorModel?
    @Published var restaurantStatus: OpenModel?
    @Published var showError: Bool = false
    
    let restaurant: RestaurantModel

    init(restaurant: RestaurantModel) {
        self.restaurant = restaurant
    }
    
    @MainActor
    func fetchRestaurantStatus() async {
        do {
            restaurantStatus = try await restaurantClient.fetchRestaurantStatus(restaurant.id)
        } catch NetworkError.errorModel(let errorModel) {
            presentedError = errorModel
            showError = true
        } catch {
            presentedError = ErrorModel(reason: "Unexpected error: \(error.localizedDescription)")
            showError = true
        }
    }
}
