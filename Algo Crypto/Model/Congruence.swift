//
//  Congruence.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 31/10/2023.
//

import Foundation
import SwiftData


@Model
final class Congruence: CalculationProtocol {
    var a: Int?
    var p: Int?
    var b: Int?
    var q: Int?
    var n: Int?
    private(set) var result: Int
    
    
    init() {
        self.a = nil
        self.p = nil
        self.b = nil
        self.q = nil
        self.n = nil
        self.result = 0
    }
    
    
    func calculate() {
        guard inputValidity() else { return }
        
        let moduloA = Modulo(x: a!, a: p!, n: n!)
        let moduloB = Modulo(x: b!, a: q!, n: n!)
        moduloA.calculate()
        moduloB.calculate()
        
        let mA = moduloA.result
        let mB = moduloB.result
        
        
        let eea = ExtendedEuclidAlgo(a: mA, b: n!)
        eea.calculate()
        
        if eea.r != nil && eea.r! != 0 {
            let tempResult: Double = Double(mB * eea.u) / Double(eea.r!)
            if floor(tempResult) == tempResult {
                result = Int(tempResult) % n!
                if result < 0 {
                    result = n! + result
                }
                print("\nn = \(n!)\nmA = \(mA)\n(\(mB) * \(eea.u)) / \(eea.r!) = \(tempResult)")
            } else {
                result = -444
            }
        } else {
            result = -444
        }
    }
    
    
    
    func inputValidity() -> Bool {
        guard a != nil && p != nil && b != nil && q != nil && n != nil else { return false }
        guard p! > 0 && q! > 0 && n! > 1 else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "$\(a ?? 0)^{\(p ?? 0)} \\times x ≡ \(b ?? 0)^{\(q ?? 0)}[\(n ?? 0)]$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        
        if result == -444 {
            return "Aucune solution"
        }
        return "x = \(result)"
    }
    
    
    func resetInputs() {
        self.a = nil
        self.p = nil
        self.b = nil
        self.q = nil
        self.n = nil
        self.result = 0
    }
}






extension Int {
    func power(_ exp: Int, modulus: Int) -> Int {
        var result = 1
        var base = self % modulus

        var exp = exp
        while exp > 0 {
            if exp % 2 == 1 {
                result = (result * base) % modulus
            }
            base = (base * base) % modulus
            exp /= 2
        }

        return result
    }
}
