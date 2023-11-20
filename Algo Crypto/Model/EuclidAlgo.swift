//
//  EuclidAlgo.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 30/10/2023.
//

import Foundation
import SwiftData
import Combine


@Model
final class EuclidAlgo: CalculationProtocol {
    var a: Int?
    var b: Int?
    private(set) var r: Int
    
    init() {
        self.a = nil
        self.b = nil
        self.r = 0
    }
    
    init(a: Int?, b: Int?, r: Int) {
        self.a = a
        self.b = b
        self.r = r
    }
    
    
    
    func calculate() {
        guard inputValidity() else {
            self.r = 0
            return
        }
        
        // x et y sont des copies de a et b, car r et q sont toujours calculés et n'ont jamais besoin d'être stockés (q inutile, et r = a % b)
        var x = self.a!
        var y = self.b!
        self.r = 1
        
        while r > 0 {
            self.r = x % y
            x = y
            y = self.r
        }
        self.r = x
    }
    
    
    
    func inputValidity() -> Bool {
        guard a != 0 && b != 0 else { return false }
        guard a != nil && b != nil else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "gcd(\(a ?? 0), \(b ?? 0))"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        return "\(r)"
    }
    
    
    func resetInputs() {
        self.a = nil
        self.b = nil
        self.r = 0
    }
}
