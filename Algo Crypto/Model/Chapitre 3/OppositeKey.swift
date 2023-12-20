//
//  OppositeKey.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData


@Model
class OppositeKey {
    var originalKey: Int?
    var phi: Int?
    var finalKey: Int
    
    init(originalKey: Int? = nil, phi: Int? = nil, finalKey: Int = 0) {
        self.originalKey = originalKey
        self.phi = phi
        self.finalKey = finalKey
    }
    
    func setEvery(originalKey: Int?, phi: Int?, finalKey: Int) {
        self.originalKey = originalKey
        self.phi = phi
        self.finalKey = finalKey
    }
}
