//
//  ExtendedEuclidAlgo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import Foundation
import SwiftData


@Model
final class ExtendedEuclidAlgo: CalculationProtocol {
    var a: Int?
    var b: Int?
    private(set) var u: Int
    private(set) var v: Int
    private(set) var r: Int?
    private(set) var q: Int?
    
    init() {
        self.a = nil
        self.b = nil
        self.u = 1
        self.v = 0
        self.r = nil
        self.q = nil
    }
    
    
    init(a: Int?, b: Int?) {
        self.a = a
        self.b = b
        self.u = 1
        self.v = 0
        self.r = nil
        self.q = nil
    }
    
    
    
    func calculate() {
        guard inputValidity() else { return }
        
        self.u = 1
        self.v = 0
        var u1 = 0
        var v1 = 1
        self.r = a!
        var r1 = b!
        
        while r1 > 0 {
            self.q = r! / r1
            (u, u1) = (u1, u - q! * u1)
            (v, v1) = (v1, v - q! * v1)
            (r, r1) = (r1, r! - q! * r1)
        }
    }
    
    
    
    func inputValidity() -> Bool {
        guard a != nil && b != nil else { return false }
        guard a != 0 && b != 0 else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "gcd(\(a ?? 0), \(b ?? 0))"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        return "\(r ?? 0)"
    }
    
    
    func resetInputs() {
        self.a = nil
        self.b = nil
        self.u = 1
        self.v = 0
        self.r = nil
        self.q = nil
    }
}
