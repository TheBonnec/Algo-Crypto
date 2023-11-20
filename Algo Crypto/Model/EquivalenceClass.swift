//
//  EquivalenceClass.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 08/11/2023.
//

import Foundation
import SwiftData


@Model
final class EquivalenceClass: CalculationProtocol {
    var a: Int?
    var n: Int?
    private(set) var equivalences: [Int]
    
    init() {
        self.a = nil
        self.n = nil
        self.equivalences = []
    }
    
    init(a: Int? = nil, n: Int? = nil, equivalences: [Int]) {
        self.a = a
        self.n = n
        self.equivalences = equivalences
    }
    
    
    
    func calculate() {
        guard inputValidity() else { return }
        
        let limit = 4 * n!
        equivalences = []
        
        for i in 1..<limit {
            if i % n! == a! {
                equivalences.append(i)
            }
        }
    }
    
    
    
    func inputValidity() -> Bool {
        guard a != nil && n != nil else { return false }
        guard a! > 0 && n! > 0 else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "dans  $\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}}$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        
        if a! < n! {
            var equivalenceText = ""
            for e in equivalences {
                equivalenceText += "\(e), "
            }
            return "$\\bar{\(a!)} = [\(equivalenceText)...]$"
        }
        return "Pas de solution pour a > n"
    }
    
    
    func resetInputs() {
        self.a = nil
        self.n = nil
        self.equivalences = []
    }
}
