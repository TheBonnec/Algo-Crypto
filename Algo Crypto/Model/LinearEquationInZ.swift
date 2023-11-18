//
//  EquationSolver.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 09/11/2023.
//

import Foundation
import SwiftData


@Model
final class LinearEquationInZ: CalculationProtocol {
    
    var a: Int?
    var b: Int?
    var n: Int?
    private(set) var result: [Int]
    
    
    init() {
        self.a = nil
        self.b = nil
        self.n = nil
        self.result = []
    }
    
    init(a: Int?, b: Int?, n: Int?, result: [Int]) {
        self.a = a
        self.b = b
        self.n = n
        self.result = result
    }
    
    
    
    func calculate() {
        guard inputValidity() else { return }
        
        self.result = []
        
        let extendedEuclid = ExtendedEuclidAlgo(a: n, b: a)
        extendedEuclid.calculate()
        
        if extendedEuclid.r == 1 {
            let invA = InverseInZ(a: a, n: n)
            invA.calculate()
            self.result.append((invA.inverse * b!) % n!)
            
        } else if b! % extendedEuclid.r! == 0 {
            let nbRep = extendedEuclid.r!
            
            let gcd1 = EuclidAlgo(a: a, b: b, r: 0)
            gcd1.calculate()
            let gcd2 = EuclidAlgo(a: gcd1.r, b: n, r: 0)
            gcd2.calculate()
            
            let na = Int(a! / gcd2.r)
            let nb = Int(b! / gcd2.r)
            let nn = Int(n! / gcd2.r)
            
            var p = 0
            
            for i in 0..<nn {
                if i * na % nn == nb {
                    p = i
                    self.result.append(p)
                    break
                }
            }
            
            guard self.result != [] else { return }
            while self.result.count < nbRep {
                self.result.append(self.result.last! + nn)
            }
        }
    }
    
    
    
    func inputValidity() -> Bool {
        guard a != nil && b != nil && n != nil else { return false }
        guard a! >= 0 && b! >= 0 && n! > 0 else { return false }
        return true
    }
    
    
    
    func displayLabel() -> String {
        return "Pour $x \\times \(a ?? 0) = \(b ?? 0)[\(n ?? 0)]$, x peut prendre les valeurs suivantes :"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "Input Error" }
        
        var listString = ""
        for e in self.result {
            listString.append("\(e), ")
        }
        if !listString.isEmpty {
            listString.removeLast()
            listString.removeLast()
            return "\(listString)"
        } else {
            return "x n'a pas de solution"
        }
    }
    
    
    func resetInputs() {
        self.a = nil
        self.b = nil
        self.n = nil
        self.result = []
    }
}
