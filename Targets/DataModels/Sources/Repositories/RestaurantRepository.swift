//
//  RestaurantRepository.swift
//  DataModels
//
//  Created by Ozgur Ersoz on 2023-08-17.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation

public struct RestaurantRepository {
    private let networkManager = NetworkManager()

    public init() { }
    
    public func fetchRestaurants() async throws -> [RestaurantModel] {
        struct RestaurantResponseModel: Decodable {
            let restaurants: [RestaurantModel]
        }
        
        return try await networkManager.performRequest(
            path: "/restaurants",
            method: .get,
            responseType: RestaurantResponseModel.self
        ).restaurants
    }
    
    public func fetchFilterItemsWithIdList(_ ids: [String]) async throws -> [FilterModel] {
        await withTaskGroup(of: FilterModel?.self, returning: [FilterModel].self, body: { taskGroup in
            var filterResponses: [FilterModel] = []
            for id in ids {
                taskGroup.addTask {
                    do {
                        return try await networkManager.performRequest(
                            path: "/filter/\(id)",
                            method: .get,
                            responseType: FilterModel.self
                        )
                    } catch {
                        debugPrint(error)
                        return nil
                    }
                }
            }
            
            for await filterResponse in taskGroup {
                if let filterResponse { filterResponses.append(filterResponse) }
            }
            
            return filterResponses
        })
    }

    public func checkRestaurantStatus(withId id: String) async throws -> OpenModel {
        return try await networkManager.performRequest(
            path: "/open/\(id)",
            method: .get,
            responseType: OpenModel.self
        )
    }
}
