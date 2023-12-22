//
//  OppositeKeyElGamal.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 22/12/2023.
//

import Foundation
import SwiftData


@Model
class OppositeKeyElGamal {
    var mode: OppositeKeyElGamalMode
    var n: Int?     // Domaine Inv(Z/nZ)
    var g: Int?     // générateur
    var eA: Int?    // Clé publique
    var dA: Int?    // Clé privée
    var result: Int
    
    
    init(mode: OppositeKeyElGamalMode = .eA, n: Int? = nil, g: Int? = nil, eA: Int? = nil, dA: Int? = nil, result: Int = 0) {
        self.mode = mode
        self.n = n
        self.g = g
        self.eA = eA
        self.dA = dA
        self.result = result
    }
    
    func setEvery(mode: OppositeKeyElGamalMode, n: Int?, g: Int?, eA: Int?, dA: Int?, result: Int) {
        self.mode = mode
        self.n = n
        self.g = g
        self.eA = eA
        self.dA = dA
        self.result = result
    }
}


enum OppositeKeyElGamalMode: Int, Codable {
    case eA = 0
    case dA = 1
}
