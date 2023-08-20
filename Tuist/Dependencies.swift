//
//  Dependencies.swift
//  Config
//
//  Created by Ozgur Ersoz on 2023-08-17.
//

import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init(
        [
            .package(url: "https://github.com/pointfreeco/swift-dependencies", .branch("main"))
        ],
        productTypes: [
            "Dependencies": .framework,
            "XCTestDynamicOverlay": .framework,
            "Clocks": .framework,
            "CombineSchedulers": .framework,
            "ConcurrencyExtras": .framework
        ]
    )
)

