//
//  LinearEquationInZVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 21/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class LinearEquationInZVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var a: Int?
    @Published var b: Int?
    @Published var n: Int?
    private var model: LinearEquationInZ?
    var result: [Int] {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.a = nil
        self.b = nil
        self.n = nil
        self.model = nil
    }
    
    init(model: LinearEquationInZ) {
        self.a = model.a
        self.b = model.b
        self.n = model.n
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> [Int] {
        if model != nil { return model!.result }
        guard inputValidity() else { return [] }
        
        var r: [Int] = []
        
        let extendedEuclid = ExtendedEuclidAlgoVM(a: n, b: a)
        
        if extendedEuclid.result.r == 1 {
            let invA = InverseInZVM(a: a, n: n)
            r.append((invA.inverse * b!) % n!)
            
        } else if b! % extendedEuclid.result.r! == 0 {
            let nbRep = extendedEuclid.result.r!
            
            let gcd1 = EuclidAlgoVM(a: a, b: b)
            let gcd2 = EuclidAlgoVM(a: gcd1.result, b: n)
            
            let na = Int(a! / gcd2.result)
            let nb = Int(b! / gcd2.result)
            let nn = Int(n! / gcd2.result)
            
            var p = 0
            
            for i in 0..<nn {
                if i * na % nn == nb {
                    p = i
                    r.append(p)
                    break
                }
            }
            
            if r != [] {
                while r.count < nbRep {
                    r.append(r.last! + nn)
                }
            }
        }
        
        return r
    }
    
    
    func inputValidity() -> Bool {
        guard self.a != nil && self.b != nil && self.n != nil else { return false }
        guard self.a! >= 0 && self.b! >= 0 && self.n! > 0 else { return false }
        return true
    }
    
    
    func resetInputs() {
        self.a = nil
        self.b = nil
        self.n = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = LinearEquationInZ(a: a, b: b, n: n, result: result)
        } else {
            model!.setEvery(a: a, b: b, n: n, result: result)
        }
        context.insert(model!)
        return true
    }
    
    func deleteModel(context: ModelContext) {
        guard self.model != nil else { return }
        guard inputValidity() else { return }
        context.delete(self.model!)
    }
    
    
    func displayLabel() -> String {
        return "\("For".localized()) $x \\times \(a ?? 0) = \(b ?? 0)[\(n ?? 0)]$, x \("canTakeValue".localized())"
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        
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
}
