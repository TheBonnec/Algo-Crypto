//
//  HasDuplicates.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftUI


extension Array where Element: Hashable {
    func hasDuplicates() -> Bool {
        var seen = Set<Element>()

        for number in self {
            if seen.contains(number) {
                return true
            }
            seen.insert(number)
        }

        return false
    }
}
