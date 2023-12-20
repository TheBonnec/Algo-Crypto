//
//  Letter.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 24/11/2023.
//

import Foundation


struct Letter: Identifiable, Equatable {
    let id = UUID()
    var value: String
    var selected: Bool
    
    init(_ value: String, selected: Bool = false) {
        self.value = value
        self.selected = selected
    }
}
