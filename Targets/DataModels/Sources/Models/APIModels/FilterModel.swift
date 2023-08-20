//
//  FilterModel.swift
//  DataModels
//
//  Created by Ozgur Ersoz on 2023-08-17.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation

public struct FilterModel: Decodable, Identifiable {
    public let name: String
    public let imageUrl: URL?
    public let id: String
    public var selected: Bool = false
    
    public init(name: String, imageUrl: URL?, id: String) {
        self.name = name
        self.imageUrl = imageUrl
        self.id = id
    }

    enum CodingKeys: String, CodingKey {
        case name
        case imageUrl = "image_url"
        case id
    }
    
    public mutating func setSelected(_ selected: Bool) {
        self.selected = selected
    }
}

