//
//  InverseInZ.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 09/11/2023.
//

import Foundation
import SwiftData


@Model
final class InverseInZ: CalculationProtocol {
    var a: Int?
    var n: Int?
    private(set) var inverse: Int
    
    
    init() {
        self.a = nil
        self.n = nil
        self.inverse = -1
    }
    
    init(a: Int? = nil, n: Int? = nil) {
        self.a = a
        self.n = n
        self.inverse = -1
    }
    
    
    
    func calculate() {
        guard inputValidity() else { 
            self.inverse = -1
            return
        }
        
        guard self.a! < self.n! else {
            self.inverse = -2
            return
        }
        
        let extendedEA = ExtendedEuclidAlgo(a: a, b: n)
        extendedEA.calculate()
        
        guard extendedEA.r == 1 else {
            self.inverse = -1
            return
        }
        self.inverse = (extendedEA.u + n!) % n!
    }
    
    
    
    func inputValidity() -> Bool {
        guard a != nil && n != nil else { return false }
        guard a! >= 0 && n! > 0 else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "Inverse of \(a ?? 0) in $\\frac{\\mathbb{Z}}{\(n ?? 0)\\mathbb{Z}}$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        
        if inverse == -1 {
            return "No inverse for \(a!)"
        } else if inverse == -2 {
            return "No inverse for $a \\geq n$"
        }
        return "\(inverse)"
    }
    
    
    func resetInputs() {
        self.a = nil
        self.n = nil
        self.inverse = -1
    }
}
