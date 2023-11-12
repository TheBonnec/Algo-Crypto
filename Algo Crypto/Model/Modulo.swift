//
//  Modulo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 31/10/2023.
//

import Foundation
import SwiftData


@Model
final class Modulo: CalculationProtocol {
    var x: Int?
    var a: Int?
    var n: Int?
    private(set) var result: Int
    
    init(x: Int? = nil, a: Int? = nil, n: Int? = nil) {
        self.x = x
        self.a = a
        self.n = n
        self.result = 0
    }
    
    init() {
        self.x = nil
        self.a = nil
        self.n = nil
        self.result = 0
    }
    
    
    func calculate() {
        guard inputValidity() else { return }
        
        result = 1
        var base = x! % n!
        var exp = a
        
        while exp! > 0 {
            if exp! % 2 == 1 {
                result = (result * base) % n!
            }
            
            base = (base * base) % n!
            exp! /= 2
        }
    }
    
    
    
    func inputValidity() -> Bool {
        guard x != nil && a != nil && n != nil else { return false }
        guard a! > 0 && n! > 0 else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "$\(x ?? 0)^{\(a ?? 0)}[\(n ?? 0)]$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        return "\(result)[\(n!)]"
    }
    
    func displayInfo() -> String {
        return "$\(x ?? 0)^{\(a ?? 0)}[\(n ?? 0)]   =   \(result)[\(n ?? 0)]$"
    }
}
