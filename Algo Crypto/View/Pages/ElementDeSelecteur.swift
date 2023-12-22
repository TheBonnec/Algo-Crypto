//
//  ElementDeSelecteur.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/12/2023.
//

import Foundation
import CIUAisen


class ElementDeSelecteur: Selectionnable {
    var id = UUID()
    var clé: String
    
    required init() {
        self.clé = "Random"
    }
    
    init(clé: String) {
        self.clé = clé
    }
    
    static func == (lhs: ElementDeSelecteur, rhs: ElementDeSelecteur) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
