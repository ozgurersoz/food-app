//
//  RestaurantsViewModelTests.swift
//  AppTest
//
//  Created by Ozgur Ersoz on 2023-08-19.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import XCTest
import Dependencies
import DataModels

@testable import RestaurantsFeature

final class RestaurantsViewModelTests: XCTestCase {
    
    func testSelectFilterItem() async throws {
        let viewModel = withDependencies {
            $0.restaurantClient = .testValue
        } operation: {
            RestaurantsViewModel()
        }
        
        await viewModel.fetchRestaurants()
        
        guard let randomfilterItem = MockData.filterItems.randomElement()?.id else {
            XCTFail("Must have a random filter item from MockData")
            return
        }
        
        viewModel.prepareFilteredData(byFilterId: randomfilterItem)
        
        guard viewModel.filterItems
            .filter({ $0.selected })
            .contains(where: { $0.id == randomfilterItem })
        else {
            XCTFail("There should be at least one selected filter item that has \(randomfilterItem) id")
            return
        }
       
        let filteredRestaurants = viewModel.restaurants.compactMap { restaurant  in
            return restaurant.visible == true ? restaurant : nil
        }
        XCTAssert(filteredRestaurants.count > 0)
        XCTAssert(filteredRestaurants.count <= MockData.restaurants.count)
    }
    
    func testDeSelectFilterItem() async throws {
        let viewModel = withDependencies {
            $0.restaurantClient = .testValue
        } operation: {
            RestaurantsViewModel()
        }
        
        await viewModel.fetchRestaurants()
        
        guard let randomfilterItem = MockData.filterItems.randomElement()?.id else {
            XCTFail("Must have a random filter item from MockData")
            return
        }
        
        // Select filter Item
        viewModel.prepareFilteredData(byFilterId: randomfilterItem)
        guard viewModel.filterItems
            .filter({ $0.selected })
            .contains(where: { $0.id == randomfilterItem })
        else {
            XCTFail("There should be at least one selected filter item that has \(randomfilterItem) id")
            return
        }
       
        let filteredRestaurants = viewModel.restaurants.compactMap { restaurant  in
            return restaurant.visible == true ? restaurant : nil
        }
        
        XCTAssert(filteredRestaurants.count <= MockData.restaurants.count)
        
        // Tap same item to deselect
        viewModel.prepareFilteredData(byFilterId: randomfilterItem)
        
        let filteredRestaurantsAfterDeselect = viewModel.restaurants.compactMap { restaurant  in
            return restaurant.visible == true ? restaurant : nil
        }
        XCTAssertEqual(filteredRestaurantsAfterDeselect.count, MockData.restaurants.count)
        
        guard viewModel.restaurants.filter({ $0.visible == false }).isEmpty else {
            XCTFail("All restaurants must be visible")
            return
        }
        
        guard viewModel.filterItems.filter({ $0.selected == true }).isEmpty else {
            XCTFail("There shouldn't be any selected filter")
            return
        }
    }
    
    func test_WhenWrongFilterIdUsed() async throws {
        let viewModel = withDependencies {
            $0.restaurantClient = .testValue
        } operation: {
            RestaurantsViewModel()
        }
        
        await viewModel.fetchRestaurants()

        viewModel.prepareFilteredData(byFilterId: "random_fake_id")
        
        let filteredRestaurants = viewModel.restaurants.compactMap { restaurant  in
            return restaurant.visible == true ? restaurant : nil
        }
        
        XCTAssertEqual(filteredRestaurants.count, MockData.restaurants.count)

        guard viewModel.filterItems.filter({ $0.selected == true }).isEmpty else {
            XCTFail()
            return
        }
        
        guard viewModel.restaurants.filter({ $0.visible == false }).isEmpty else {
            XCTFail()
            return
        }
    }
    
    func test_WhenTwoFilterItemsApplied() async throws{
        let viewModel = withDependencies {
            $0.restaurantClient = .testValue
        } operation: {
            RestaurantsViewModel()
        }
        
        await viewModel.fetchRestaurants()
       
        // Random filter 1
        guard let firstFilterItem = MockData.filterItems.first?.id else {
            XCTFail()
            return
        }
        
        viewModel.prepareFilteredData(byFilterId: firstFilterItem)
        guard viewModel.filterItems
            .filter({ $0.selected })
            .contains(where: { $0.id == firstFilterItem })
        else {
            XCTFail("There should be at least one selected filter item that has \(firstFilterItem) id")
            return
        }
        
        // Random filter 2
        guard let secondFilterItem = MockData.filterItems.last?.id else {
            XCTFail()
            return
        }
        
        viewModel.prepareFilteredData(byFilterId: secondFilterItem)
        guard viewModel.filterItems
            .filter({ $0.selected })
            .contains(where: { $0.id == secondFilterItem })
        else {
            XCTFail("There should be at least one selected filter item that has \(secondFilterItem) id")
            return
        }
        
        let filteredRestaurants = viewModel.restaurants.compactMap { restaurant  in
            return restaurant.visible == true ? restaurant : nil
        }
        XCTAssert(filteredRestaurants.count >= 0)
        XCTAssert(filteredRestaurants.count <= MockData.restaurants.count)
    }
}
