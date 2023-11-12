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
    var x: Int?
    var a: Int?
    var y: Int?
    var b: Int?
    var n: Int?
    private(set) var result: Int
    
    
    init() {
        self.x = nil
        self.a = nil
        self.y = nil
        self.b = nil
        self.n = nil
        self.result = 0
    }
    
    
    func calculate() {
        guard inputValidity() else { return }
        
        let moduloA = Modulo(x: x!, a: a!, n: n!)
        let moduloB = Modulo(x: y!, a: b!, n: n!)
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
        guard x != nil && a != nil && y != nil && b != nil && n != nil else { return false }
        guard a! > 0 && b! > 0 && n! > 1 else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "$\(x ?? 0)^{\(a ?? 0)} \\times x ≡ \(y ?? 0)^{\(b ?? 0)}[\(n ?? 0)]$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        
        if result == -444 {
            return "Aucune solution"
        }
        return "x = \(result)"
    }
    
    func displayInfo() -> String {
        return "\(x ?? 0)^\(a ?? 0) * x ≡ \(y ?? 0)^\(b ?? 0)[\(n ?? 0)]   ->   x = \(result)"
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
