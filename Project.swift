import ProjectDescription
import ProjectDescriptionHelpers

// Creates our project using a helper function defined in ProjectDescriptionHelpers
let project = Project(
    name: "iRest",
    organizationName: "Apple Food Inc",
    options: .defaultOptions(),
    targets: [
        Target(
            name: "App",
            platform: .iOS,
            product: .app,
            bundleId: "se.irest.app",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
            infoPlist: .appInfoPlist(),
            sources: ["Targets/App/Sources/**"],
            dependencies: [
                .target(name: "RestaurantsFeature"),
                .target(name: "DataModels"),
                .external(name: "Dependencies")
            ]
        ),
        Target(
            name: "AppTest",
            platform: .iOS,
            product: .unitTests,
            bundleId: "se.irest.app.test",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
            infoPlist: .appInfoPlist(),
            sources: ["Targets/App/Tests/**"],
            resources: ["Targets/App/Resources/**"],
            dependencies: [
                .target(name: "App")
            ]
        ),
        Target(
            name: "RestaurantsFeature",
            platform: .iOS,
            product: .framework,
            bundleId: "iRest.restaurantsFeature",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
            sources: ["Targets/RestaurantsFeature/Sources/**"],
            dependencies: [
                .external(name: "Dependencies"),
                .target(name: "DataModels"),
                .target(name: "DesignSystem"),
            ]
        ),
        Target(
            name: "RestaurantsFeatureTests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "iRest.restaurantsFeature.test",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
            sources: ["Targets/RestaurantsFeature/Tests/**"],
            dependencies: [
                .target(name: "RestaurantsFeature")
            ]
        ),
        Target(
            name: "DataModels",
            platform: .iOS,
            product: .framework,
            bundleId: "iRest.dataModels",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
            sources: ["Targets/DataModels/Sources/**"],
            dependencies: [
                .external(name: "Dependencies")
            ]
        ),
        Target(
            name: "DesignSystem",
            platform: .iOS,
            product: .framework,
            bundleId: "iRest.designSystem",
            deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
            sources: ["Targets/DesignSystem/Sources/**"],
            resources: ["Targets/DesignSystem/Resources/**"],
            dependencies: []
        )
    ]
)
