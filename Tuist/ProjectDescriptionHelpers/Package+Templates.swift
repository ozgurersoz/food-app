//
//  Package+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Ozgur Ersoz on 2023-04-25.
//

import ProjectDescription

extension Project {

    public static func packageFramework(
        name: String,
        includePreviewTarget: Bool = false,
        resources: ProjectDescription.ResourceFileElements? = nil,
        dependencies: [TargetDependency] = [],
        previewDependencies: [TargetDependency] = []
    ) -> Project {

        var targets: [ProjectDescription.Target] = [
            Target(
                name: name,
                platform: .iOS,
                product: .framework,
                bundleId: "com.CoolRealEstate.app.\(name)",
                infoPlist: nil,
                sources: ["Sources/**"],
                resources: resources,
                dependencies: dependencies
            ),
            Target(
                name: "\(name)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "com.CoolRealEstate.app.\(name)Tests",
                infoPlist: nil,
                sources: ["Tests/**"],
                dependencies: [.target(name: name)]
            )
        ]

        if includePreviewTarget {
            let previewTarget = Target(
                name: "\(name)Preview",
                platform: .iOS,
                product: .app,
                bundleId: "com.CoolRealEstate.app.\(name)Preview",
                infoPlist: .dictionary([
                    "UIApplicationSceneManifest": .dictionary([
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": .dictionary([:])
                    ]),
                    "UILaunchScreen": .dictionary([:])
                ]),
                sources: [
                    "Preview/**"
                ],
                dependencies: [
                    .project(target: name, path: ".")
                ] + previewDependencies,
                settings: .settings(
                    base: [:]
                        .automaticCodeSigning(devTeam: "Y9RHT6835K")
                )
            )
            targets.append(previewTarget)
        }

        return Project(
            name: name,
            organizationName: "Cool RealEstate Company AB",
            options: .defaultOptions(),
            settings: .settings(
                base: [
                    "GENERATE_INFOPLIST_FILE": true,
                    "MARKETING_VERSION": .string("1.0"),
                    "CURRENT_PROJECT_VERSION": .string("1")
                ]
            ),
            targets: targets,
            fileHeaderTemplate: .file(.relativeToRoot("Tuist/Templates/FileHeaderComment"))
        )
    }
}
