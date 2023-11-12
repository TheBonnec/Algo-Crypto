//
//  AdditionInZ.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 08/11/2023.
//

import Foundation
import SwiftData


@Model
final class AdditionInZ: CalculationProtocol {
    var a: Int?
    var b: Int?
    var n: Int?
    private(set) var result: Int
    
    
    init() {
        self.a = nil
        self.b = nil
        self.n = nil
        self.result = 0
    }
    
    init(a: Int? = nil, b: Int? = nil, n: Int? = nil, result: Int) {
        self.a = a
        self.b = b
        self.n = n
        self.result = result
    }
    
    
    
    func calculate() {
        guard inputValidity() else { return }
        
        let am = a! % n!
        let bm = b! % n!
        self.result = (am + bm) % n!
    }
    
    
    
    func inputValidity() -> Bool {
        guard a != nil && b != nil && n != nil else { return false }
        guard a! >= 0 && b! >= 0 && n! > 0 else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "$\\bar{\(a ?? 0)} ⊕ \\bar{\(b ?? 0)} =$"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        return "\(result)"
    }
    
    func displayInfo() -> String {
        return "$\\bar{\(a ?? 0)} ⊕ \\bar{\(b ?? 0)} = \\bar{\(result)}$"
    }
}
