//
//  PolynomialEquationVM.swift
//  Algo Crypto
//
//  Created by Thomas Le Bonnec on 26/11/2023.
//

import Foundation
import SwiftData
import SwiftUI
import Combine


class PolynomialEquationVM: ObservableObject, CalculationVMProtocol {
    
    /* ----- Propriétés ----- */
    
    var id = UUID()
    
    @Published var mode: PolynomialMode
    @Published var a: Int?
    @Published var b: Int?
    @Published var n: Int?
    @Published var p: Int?
    @Published var q: Int?
    private var model: PolynomialEquation?
    var result: Int {
        calculate()
    }
    
    
    
    /* ----- Inits ----- */
    
    required init() {
        self.mode = .n
        self.a = nil
        self.b = nil
        self.n = nil
        self.p = nil
        self.q = nil
        self.model = nil
    }
    
    init(model: PolynomialEquation) {
        self.mode = model.mode
        self.a = model.a
        self.b = model.b
        self.n = model.n
        self.p = model.p
        self.q = model.q
        self.model = model
    }
    
    
    
    /* ----- Méthodes ----- */
    
    func calculate() -> Int {
        guard inputValidity() else { return -1 }
        
        var phi: PhiVM
        var modulo: Int
        
        switch mode {
        case .n: 
            phi = PhiVM(n: n!)
            modulo = n!
        case .pq:
            phi = PhiVM(p: p!, q: q!)
            modulo = p! * q!
        }
        
        let eea = ExtendedEuclidAlgoVM(a: a!, b: phi.result)
        let d = (eea.result.u + phi.result) % phi.result
        let x = ModuloVM(x: b!, a: d, n: modulo)
        
        return x.result
    }
    
    
    func inputValidity() -> Bool {
        guard self.a != nil && self.b != nil else { return false }
        guard self.a! > 0 && self.b! >= 0 else { return false }
        
        switch mode {
        case .n:
            guard self.n != nil else { return false }
            guard self.n! > 1 else { return false }
            return true
        case .pq:
            guard self.p != nil && self.q != nil else { return false }
            guard self.p! > 0 && self.q! > 0 else { return false }
            return true
        }
    }
    
    
    func resetInputs() {
        self.a = nil
        self.b = nil
        self.n = nil
        self.p = nil
        self.q = nil
        self.model = nil
    }
    
    
    func saveModel(context: ModelContext) -> Bool {
        guard inputValidity() else { return false }
        if model == nil {
            model = PolynomialEquation(mode: mode, a: a, b: b, n: n, p: p, q: q, result: result)
        } else {
            model!.setEvery(mode: mode, a: a, b: b, n: n, p: p, q: q, result: result)
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
        switch mode {
        case .n: return "$x^{\(a ?? 0)} ≡ \(b ?? 0)[\(n ?? 0)]$"
        case .pq: return "$x^{\(a ?? 0)} ≡ \(b ?? 0)[\(p ?? 0) \\times \(q ?? 0)]$"
        }
    }
    
    func displayResult() -> String {
        guard inputValidity() else { return "InputError".localized() }
        switch mode {
        case .n:
            let primeFactor = PrimeFactorsVM(n: n!)
            guard !primeFactor.factors.hasDuplicates() else { return "Pas de solution !" }
        case .pq:
            guard self.p!.isPrime() && self.q!.isPrime() else { return "Pas de solution !" }
        }
        return "x = \(result)"
    }
}
