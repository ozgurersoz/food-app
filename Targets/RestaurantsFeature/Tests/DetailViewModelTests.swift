//
//  DetailViewModelTests.swift
//  AppTest
//
//  Created by Ozgur Ersoz on 2023-08-20.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import XCTest
import Dependencies
import DataModels

@testable import RestaurantsFeature


final class DetailViewModelTests: XCTestCase {
    func test_fetchRestaurantStatus() async {
        MockData.restaurants.addTags(from: MockData.filterItems)
        let mockRestaurant = MockData.restaurants.first!
        
        let viewModel = withDependencies {
            $0.restaurantClient = .testValue
        } operation: {
            DetailViewModel(restaurant: mockRestaurant)
        }
        
        await viewModel.fetchRestaurantStatus()
        
        XCTAssertEqual(viewModel.restaurantStatus?.isOpen, true)
    }
    
    func test_fetchRestaurantStatusError() async {
        MockData.restaurants.addTags(from: MockData.filterItems)
        let mockRestaurant = MockData.restaurants.first!
        
        let viewModel = withDependencies {
            $0.restaurantClient.fetchRestaurantStatus = { _ in
                throw NetworkError.errorModel(.init(reason: "Wrong id"))
            }
        } operation: {
            DetailViewModel(restaurant: mockRestaurant)
        }
        
        await viewModel.fetchRestaurantStatus()
        
        XCTAssertNil(viewModel.restaurantStatus)
        XCTAssertEqual(viewModel.presentedError?.reason, "Wrong id")
    }
}
