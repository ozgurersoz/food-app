//
//  ErrorModel.swift
//  DataModels
//
//  Created by Ozgur Ersoz on 2023-08-20.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation

public struct ErrorModel: Error, Decodable {
    public let reason: String
    
    public init(reason: String) {
        self.reason = reason
    }
}
