//
//  Array+RemoveDuplicate.swift
//  App
//
//  Created by Ozgur Ersoz on 2023-08-20.
//  Copyright © 2023 Apple Food Inc. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    public func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    public  mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
