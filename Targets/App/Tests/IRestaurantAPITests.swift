import Foundation
import XCTest
import DataModels
import Dependencies

@testable import App

final class IRestaurantAPITests: XCTestCase {
    func testRestaurantsEndpoint() async throws {
        let restaurantRepository = RestaurantRepository()
        let restaurants = try await restaurantRepository.fetchRestaurants()
        let filterItems = restaurants.flatMap(\.filterIds).removingDuplicates()
        let filterModels = try await restaurantRepository.fetchFilterItemsWithIdList(filterItems)
        
        XCTAssert(restaurants.count > 0)
        XCTAssert(filterModels.count > 0)
    }
    
    func testOpenEndpoint() async throws {
        let restaurantRepository = RestaurantRepository()
        do {
            let status = try await restaurantRepository.checkRestaurantStatus(withId: "7450001")
        } catch NetworkError.errorModel(let errorModel) {
            XCTFail(errorModel.reason)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testOpenEndpointErrorCase() async throws {
        let restaurantRepository = RestaurantRepository()
        do {
            let status = try await restaurantRepository.checkRestaurantStatus(withId: "a_fake_id")
            XCTFail("Should thrown error")
        } catch NetworkError.errorModel(let errorModel) {
            XCTAssertFalse(errorModel.reason.isEmpty)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
