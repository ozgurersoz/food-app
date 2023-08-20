//
//  Mock.swift
//  DataModels
//
//  Created by Ozgur Ersoz on 2023-08-19.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation

public enum MockData {
    public static var filterItems = [
        FilterModel(
            name: "Top Rated",
            imageUrl: URL(string: "https://food-delivery.umain.io/images/filter/filter_top_rated.png"),
            id: "5c64dea3-a4ac-4151-a2e3-42e7919a925d"
        ),
        
        FilterModel(
            name: "Eat-in",
            imageUrl: URL(string: "https://food-delivery.umain.io/images/filter/filter_eat_in.png"),
            id: "0017e59c-4407-453f-a5be-901695708015"
        ),
        
        FilterModel(
            name: "Fast delivery",
            imageUrl: URL(string: "https://food-delivery.umain.io/images/filter/filter_fast_delivery.png"),
            id: "23a38556-779e-4a3b-a75b-fcbc7a1c7a20"
        ),
        
        FilterModel(
            name: "Fast food",
            imageUrl: URL(string: "https://food-delivery.umain.io/images/filter/filter_fast_food.png"),
            id: "614fd642-3fa6-4f15-8786-dd3a8358cd78"
        ),
        
        FilterModel(
            name: "Take-Out",
            imageUrl: URL(string: "https://food-delivery.umain.io/images/filter/filter_take_out.png"),
            id: "c67cd8a3-f191-4083-ad28-741659f214d7"
        )
    ]

    public static var  restaurants = [
        RestaurantModel(
            id: "7450001",
            deliveryTimeMinutes: 9,
            rating: 4.6,
            imageURL: URL(string: "https://food-delivery.umain.io/images/restaurant/burgers.png"),
            name: "Wayne \"Chad Broski\" Burgers",
            filterIds: [
                "5c64dea3-a4ac-4151-a2e3-42e7919a925d",
                "614fd642-3fa6-4f15-8786-dd3a8358cd78",
                "c67cd8a3-f191-4083-ad28-741659f214d7",
                "23a38556-779e-4a3b-a75b-fcbc7a1c7a20"
            ]
        ),

        RestaurantModel(
            id: "7450002",
            deliveryTimeMinutes: 45,
            rating: 4.7,
            imageURL: URL(string: "https://food-delivery.umain.io/images/restaurant/candy.png"),
            name: "Yuma´s Candyshop",
            filterIds: ["5c64dea3-a4ac-4151-a2e3-42e7919a925d"]
        ),

        RestaurantModel(
            id: "7450007",
            deliveryTimeMinutes: 1,
            rating: 4.1,
            imageURL: URL(string: "https://food-delivery.umain.io/images/restaurant/meat.png"),
            name: "Emilia´s Fancy Food",
            filterIds: [
                "5c64dea3-a4ac-4151-a2e3-42e7919a925d",
                "23a38556-779e-4a3b-a75b-fcbc7a1c7a20",
                "0017e59c-4407-453f-a5be-901695708015"
            ]
        )
    ]

}
