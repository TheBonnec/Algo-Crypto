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
    var result: Int
    
    
    init() {
        self.x = nil
        self.a = nil
        self.y = nil
        self.b = nil
        self.n = nil
        self.result = 0
    }
    
    
    func calculate() {
        guard x != nil && a != nil && y != nil && b != nil && n != nil else { return }
        guard a! > 0 && b! > 0 && n! > 1 else { return }
        
        
    }
    
    
    
    func displayInfo() -> String {
        return "\(x ?? 0)^\(a ?? 0) ≡ \(y ?? 0)^\(b ?? 0)[\(n ?? 0)]   ->   \(result)"
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
