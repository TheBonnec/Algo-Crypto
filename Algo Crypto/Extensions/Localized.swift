//
//  Localized.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/11/2023.
//

import Foundation


extension String {
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
}
