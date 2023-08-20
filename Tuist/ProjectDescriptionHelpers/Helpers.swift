//
//  Helpers.swift
//  ProjectDescriptionHelpers
//
//  Created by Ozgur Ersoz on 2023-01-12.
//

import ProjectDescription

public extension InfoPlist {
    
    static func appInfoPlist() -> Self {
        let infoPlist: [String : ProjectDescription.InfoPlist.Value] = [
            "CFBundleDisplayName": .string("${APPLICATION_NAME}"),
            "CFBundleShortVersionString": .string("1.0.0"),
            "CFBundleName": .string("${APPLICATION_NAME}"),
            "UIMainStoryboardFile": "",
            "UILaunchStoryboardName": "LaunchScreen",
            "UIApplicationSceneManifest": .dictionary([
                "UIApplicationSupportsMultipleScenes": false,
                "UISceneConfigurations": .dictionary([:])
            ]),
        ]
        return extendingDefault(
            with: infoPlist
        )
    }
}

