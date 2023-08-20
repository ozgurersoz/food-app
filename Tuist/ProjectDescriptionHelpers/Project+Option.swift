//
//  Project+Option.swift
//  ProjectDescriptionHelpers
//
//  Created by Ozgur Ersoz on 2023-04-25.
//

import Foundation
import ProjectDescription

public extension Project.Options {

    static func defaultOptions(
        automaticSchemesOptions: AutomaticSchemesOptions = .enabled()
    ) -> Self {
        return .options(
            automaticSchemesOptions: automaticSchemesOptions,
            defaultKnownRegions: ["en"],
            developmentRegion: "en"
        )
    }
}
